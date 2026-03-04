Return-Path: <netdev+bounces-263778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB5TMnIaqGmgnwAAu9opvQ
	(envelope-from <netdev+bounces-263778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:41:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7654E1FF2A6
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 352B83014A0E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 11:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26622372ED3;
	Wed,  4 Mar 2026 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iYJWoCmJ"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-101.ptr.blmpb.com (sg-1-101.ptr.blmpb.com [118.26.132.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037A938424E
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624495; cv=none; b=ih0Nh4334gkZw0ecSxjT12pGT3K7isyUNFKKP0KFGkfq3maPxdMf/nOeKUDHS0IM8ZzxfNCXF+uyzZ8T9o2kVRlcYLFIUU2FGM497/EskAMjDSWnkTFu1QgOqgKfcvS6C7gYHcsWjjJY8GKRDesoy7zKeRMlC3GpBlk27krdZxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624495; c=relaxed/simple;
	bh=Zsfpv2bKAIFjeTJkR4guEJrWp05HGkQ5XxibykaWyGc=;
	h=Subject:Mime-Version:References:Date:To:Cc:From:Message-Id:
	 Content-Type:In-Reply-To; b=MgHqGlZJZV07rSEq38F6Q4CiHhRqGTYgWAgERy1fyZ8ZiDo75D5TjQw1+akugDNVltIGTJCQ/yncnFpxGLJGsTEhoOINfRNiSBJCh8vF2Ghva1OCZe1Y4sTckzq2ZWUmZuJPbPaPyGi/qX532p4iqBHUdPqPUVijiEUHgZ0dmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iYJWoCmJ; arc=none smtp.client-ip=118.26.132.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1772624481; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Vc+47iZiFSLOrhC2jUpMTxSYjpcw1G/TEW69DKggRq4=;
 b=iYJWoCmJHASbD9OCxLMF4YNNlJzTfbktGd1pOUg88AXxPWn+BuWjK/z6cnkEuMui9ny8qq
 nrzs2K/7XKbwl/h1SvLLTuezN5kHuJWLC9lwrRFdwTKY14ehp2e+bhpBWDQIgPQ0NRJeuz
 8aBn0MH9VetPY1+qjrflkXElvWUw0WGucfJN1E0i3Fb2J2cjxLtWRW7XpkCyeuj9gW1Ucr
 BAw0WiCQBLwnumW4MSlJm8Qifd7f67jDsy7Pr+0LqcMNa2Qik/F2kOcaLtSLgO7W2Raubv
 XYT1Ag8C6gFRyYGUs7TOjBBvg3GyxAwjM0EIGI1Uusf19Cl2dietGag+oyhisQ==
Subject: Re: [PATCH net] net: ncsi: fix skb leak in error paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260302054629.1347119-1-zhangjian.3032@bytedance.com> <20260304111607.GH71509@kernel.org>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 4 Mar 2026 19:40:54 +0800
To: "Simon Horman" <horms@kernel.org>
Cc: "Samuel Mendoza-Jonas" <sam@mendozajonas.com>, 
	"Paul Fertser" <fercerpav@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
From: "ByteDance" <zhangjian.3032@bytedance.com>
X-Lms-Return-Path: <lba+269a81a5f+bc6709+vger.kernel.org+zhangjian.3032@bytedance.com>
Message-Id: <C6819099-48B3-4CC3-A817-14DEBD2DEDEB@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Mailer: Apple Mail (2.3776.700.51.11.4)
In-Reply-To: <20260304111607.GH71509@kernel.org>
X-Original-From: ByteDance <zhangjian.3032@bytedance.com>
X-Rspamd-Queue-Id: 7654E1FF2A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263778-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mendozajonas.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bytedance.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangjian.3032@bytedance.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bytedance.com:dkim,bytedance.com:email,bytedance.com:mid]
X-Rspamd-Action: no action

> 2026=E5=B9=B43=E6=9C=884=E6=97=A5 19:16=EF=BC=8CSimon Horman <horms@kerne=
l.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, Mar 02, 2026 at 01:46:29PM +0800, Jian Zhang wrote:
>> Early return paths in NCSI RX and AEN handlers fail to release
>> the received skb, resulting in a memory leak.
>>=20
>> Specifically, ncsi_aen_handler() returns on invalid AEN packets
>> without consuming the skb. Similarly, ncsi_rcv_rsp() exits early
>> when failing to resolve the NCSI device, response handler, or
>> request, leaving the skb unfreed.
>>=20
>> Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
>=20
> As fixes for Networking code these should have fixes tags.
> I think the following are appropriate.
>=20
> Fixes: 7a82ecf4cfb8 ("net/ncsi: NCSI AEN packet handler")
> Fixes: 138635cc27c9 ("net/ncsi: NCSI response packet handler")
>=20
> As they seem to be commits from the same patch-set,
> included in the same release - v4.8-rc1, I think
> we can keep this as a single patch.
>=20
> If you agree then it shouldn't be necessary to post a new version because
Agreed, thanks for the review,=20
> of this, as patchwork should pick up the tags above. But for future
> reference, assuming these are backporting candidates, it's best to CC
> stable on bugfixes for net.
Got it, Thanks,  will do for future fixes.
>=20
> Overall, this looks good to me.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

