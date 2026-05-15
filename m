Return-Path: <netdev+bounces-288184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF2zGESjBmoMlgIAu9opvQ
	(envelope-from <netdev+bounces-288184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 06:38:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B95305494B9
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 06:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA69F30103AD
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480423D47AB;
	Fri, 15 May 2026 04:38:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BDA3D1CB4;
	Fri, 15 May 2026 04:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778819882; cv=none; b=idW89sgyZ9ny64b1oZDm3bgxBv7BUyAFk8X8unWYtGg/gWOQ57ZlGMwxkP2VVYfRyL3vd03PlcyWuvdiGc5ZimS3nnfO63h117hu7Pv8Tbis/+gKtxDj9THj5so1GweXAI7lqM/oeAadpNHtpnnzU55NkHx7tuwzKiRAAvEGiV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778819882; c=relaxed/simple;
	bh=D3ywJOOdtSz+6gpEUbKTjvqIUtsPJPyem0eB1g5Mo2I=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=mGvAO+ZDkBf1oVeG6LKgUkTt7vEd2so9lXOVS4ridgoQa9Wh8u+27R4/ForHK4uGaMy43SCidVOVHlUIHgbRkJbXjh0OKnfKqqyoirbYoSup4IGcbCg+1DrLM/gclSAKNhHLyGf1OiixHtx4OicQHrBNbA+YNMdnrsVz9RLg2vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gGvZQ2w5Dz5BNS0;
	Fri, 15 May 2026 12:37:50 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 64F4bjtb084514;
	Fri, 15 May 2026 12:37:45 +0800 (+08)
	(envelope-from qiu.yutan@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 15 May 2026 12:37:47 +0800 (CST)
X-Zmail-TransId: 2afb6a06a31b4ee-c5384
X-Mailer: Zmail v1.0
Message-ID: <20260515123747432jLXDLIyJm2pu_tVAMf1am@zte.com.cn>
Date: Fri, 15 May 2026 12:37:47 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <qiu.yutan@zte.com.cn>
To: <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <kuba@kernel.org>
Cc: <dsahern@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
        <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yang.chuan1@zte.com.cn>,
        <huang.jian@zte.com.cn>, <zhou.shizhen@zte.com.cn>,
        <zhang.dongyu1@zte.com.cn>, <ye.guojin@zte.com.cn>,
        <yang.wei20@zte.com.cn>, <zhang.lin16@zte.com.cn>,
        <li.hao40@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXQtbmV4dF0gbmV0OiBuZWlnaDogUmVuYW1lIE5FSUdIX1ZBUl9JTlRFUlZBTF9QUk9CRV9USU1FX01TIHRvIE5FSUdIX1ZBUl9JTlRFUlZBTF9QUk9CRV9USU1F?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 64F4bjtb084514
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: qiu.yutan@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Fri, 15 May 2026 12:37:50 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A06A31E.000/4gGvZQ2w5Dz5BNS0
X-Rspamd-Queue-Id: B95305494B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUBJ_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FAKE_REPLY(1.00)[];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[zte.com.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288184-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[qiu.yutan@zte.com.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zte.com.cn:email,zte.com.cn:mid]
X-Rspamd-Action: no action

On 5/15/26 10:55 AM, Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> From: Qiu Yutan <qiu.yutan@zte.com.cn>
>>
>> During the initialization of arp_tbl, the enumeration constant name
>> NEIGH_VAR_INTERVAL_PROBE_TIME_MS in the statement
>> arp_tbl.parms.data[NEIGH_VAR_INTERVAL_PROBE_TIME_MS] = 5*HZ does not
>> align with its actual meaning (jiffies).
>I think the macro name NEIGH_VAR_INTERVAL_PROBE_TIME is just meant to 
>correspond
>
>to the configuration item neigh/default/interval_probe_time_ms.

Thank you for your feedback.

The unit of interval_probe_time_ms is milliseconds, 
which is user-friendly. Internally in the kernel, it is actually converted 
to jiffies. Using NEIGH_VAR_INTERVAL_PROBE_TIME to match jiffies makes the 
code more readable and developer-friendly.

>>
>> Using NEIGH_VAR_INTERVAL_PROBE_TIME is a better naming choice.
>>
>> Fixes: bf48c3fae6d7 ("Merge branch 'net-neigh-introduce-interval_probe_time-for-periodic-probe'")
>
>Do not carry Fixes tag since it's not a fix. On the other hand, it is a 
>merge commit not a regular commit...

I will remove the tag in PATCH v2.

