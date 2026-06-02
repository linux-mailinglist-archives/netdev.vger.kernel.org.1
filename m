Return-Path: <netdev+bounces-294287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RjMfHOwDH2q0dAAAu9opvQ
	(envelope-from <netdev+bounces-294287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:25:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA1F6302B9
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:25:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LVhb4v6U;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294287-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294287-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F16D4302001D
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 16:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668FB3016EE;
	Tue,  2 Jun 2026 16:18:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4011B3033DE;
	Tue,  2 Jun 2026 16:18:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417085; cv=none; b=Hm7PjUMKAluB7RJV9xNHA0UetrHQE4sZDIZU4OGHxh2nlrTHFs3sLNPgAT+rA+9FNl4OIDO2CVhwV5IB0+GyVCw/PeXelBG3W1snbmGcV1cGmlMuhgyhBIbsSeXr014K0wPd0AyhB9/e/YWKAMdhDhnnR2B34SQr77wqfXC20Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417085; c=relaxed/simple;
	bh=Rvh/QCRNWypoeRbVX5OlUJF4PsltkF0tUyYMioI9AZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFfus0VnRhsu8e+MxWpULk6VyL1+6yTsUv1kvzADaP+LfObSjw1aF6jAvcLFE+ptFEdTzC8W6VKhiN45MeOL6Itnhwf/iVaPOI6yaQ9l2At9d1Nx9BdliNGtRyqLG/sx3sff9ZgGRegJYUTSRn5VycSttEJLUomEXjnG5w2/04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVhb4v6U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB261F00893;
	Tue,  2 Jun 2026 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417083;
	bh=12QO2v/oPPaXo6bAnv+kg5Ii4FyiJqb2Htu66F1W9ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LVhb4v6UKrFpmmn96bo2JUHMJaUaK7uqzcT2HE1Oowedc9kLG7NUAJkT872HQ9nTn
	 /qk+9VO8pHSFE0MlmTWA7XMOtrSABlo3htmuV/Tm9GerxpzHv/eulIIBApMKP6uyck
	 yk9kWskGXnz0UrDU7E/WqXSGwgHHBhYCp94cpN5RFRR4pCUvExwtwzStE3n+IFwwZo
	 zDPP+KxEZQTQJnGIZn5mjkwnBLCDb2LF2YkxJtEOunUK8D1tb7SfsnRF2LrChnqP/m
	 5pLSRkwMoXZi+klnE6WLIXLiwd2HMgok8BgMeA056SNSn1Wpx0NmgX6q2ujsph6apq
	 vu7vNyZbgQ8Qw==
Date: Tue, 2 Jun 2026 17:17:59 +0100
From: Simon Horman <horms@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH net] net: garp: fix unsigned integer underflow in
 garp_pdu_parse_attr
Message-ID: <20260602161759.GC3410996@horms.kernel.org>
References: <20260527083200.42861-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527083200.42861-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294287-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tsinghua.edu.cn:email,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEA1F6302B9

On Wed, May 27, 2026 at 04:31:58PM +0800, Yizhou Zhao wrote:
> The receive-side GARP attribute parser computes dlen with reversed
> operands:
> 
>         dlen = sizeof(*ga) - ga->len;
> 
> ga->len is the on-wire attribute length and includes the GARP attribute
> header. For normal attributes with data, ga->len is larger than
> sizeof(*ga), so the subtraction underflows in unsigned arithmetic.
> 
> The resulting value is later passed to garp_attr_lookup(), whose length
> argument is u8. After truncation, the parsed data length usually no
> longer matches the length stored for locally registered attributes, so
> received Join/Leave events are ignored. This breaks the GARP receive path
> for common attributes, such as GVRP VLAN registration attributes.
> 
> Compute the data length as the attribute length minus the header length.
> 
> Fixes: eca9ebac651f ("net: Add GARP applicant-only participant")
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>


Reviewed-by: Simon Horman <horms@kernel.org>

FTR, there is an AI generated review of this patch available on sashiko.dev.
I suggest that the issues raised there can be looked at in the context
of possible follow-up rather than something that blocks progress of this
patch.


