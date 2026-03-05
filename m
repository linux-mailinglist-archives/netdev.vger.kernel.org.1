Return-Path: <netdev+bounces-264518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJKmKBLZqWl5GAEAu9opvQ
	(envelope-from <netdev+bounces-264518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 20:27:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4606A217849
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 20:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C1413006B78
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 19:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99BD33509E;
	Thu,  5 Mar 2026 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Qg+qnD8o"
X-Original-To: netdev@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FAD378829
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738824; cv=none; b=D2MG7nqWq7RRYGjA2RpsW3dBAQQ2jbpxtBgaq6DDBa8623oWzC/g2RUZ8FCiMaLmoyvTd+DV+eKGBecPaV2uyF1O79pKWeRGaBbKGvsbx+NniQFMM0g8XvBNErVcWyQbgJpfY9wd1DWZxmnpkaSS6XwjJzvL/ufD3jk0rnF32CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738824; c=relaxed/simple;
	bh=CYYKmhUtg90PFt9VCmUypY1dgNUEpZWlq4p9vDQbEDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPzTMT9ngNvfcQQAARDd6Rkz+RE/idnBHZYhfk6SyILQx3R7qX+prHW+3VmfwJpYJoxay0WjE7zIL+dYMWFbAbryfNlnHiRBKdUgUSDBUYGwpN2jc5ZxRiDgjFcRVhFJRuUhQLX+hOoNetsuI1GpGgV5a/TA6dkQUAFroh3pQfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Qg+qnD8o; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id yCzTvhLICVCBNyELYv51AQ; Thu, 05 Mar 2026 19:26:57 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id yELKvMyMUN3K1yELLvW2xY; Thu, 05 Mar 2026 19:26:43 +0000
X-Authority-Analysis: v=2.4 cv=UdRRSLSN c=1 sm=1 tr=0 ts=69a9d900
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=edf1wS77AAAA:8
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=J2gJbEVsAAAA:8 a=hSkVLCK3AAAA:8
 a=C9xVZAldh4BiXX6lDm0A:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=Bt_igOxda4ASFyQEjNxY:22 a=cQPPKAXgyycSBL8etih5:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PSPKeTGGopkm3YY/++r6DnAI0CLkMITuqPkvzJJH0FM=; b=Qg+qnD8ouUAuA6RGGUJgM28p1v
	ZxxsZLYKunuqaPFONqBQ92GwS5fZPUd2CHiMH/I35qcktGB65563hbMB6tU8mRVvbxaFC3sU/XdUM
	Kgz0lNMdig32sSLAWapa8amPKlvBhV6RA2ww5qauDcoxKYkZd0KDifyG8SiZrDs1xWcR7RPrFO/SO
	QtOqdx941S1EWGRBosT+Rw/UKqwr2a+GfVOSs3KjFiZMXxVW5ptw8tyg2I4WgvFAoE/7QFRtRNCKh
	/Gdmx09ACFzrjuL0BwYAqKH0hpCO1A6WvqU2o4OEATjmtqDB4S1r5rZmIOGj61HKFZan5Dg7FxT+K
	tP0gETCw==;
Received: from [177.238.16.13] (port=52146 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vyELJ-00000000MfN-3cSS;
	Thu, 05 Mar 2026 13:26:41 -0600
Message-ID: <5c8bab4f-5821-428b-adcf-b2c0631da415@embeddedor.com>
Date: Thu, 5 Mar 2026 13:26:08 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: sched: cls_u32: Avoid memcpy()
 false-positive warning in u32_init_knode()
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+d5ace703ed883df56e42@syzkaller.appspotmail.com,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260305073343.250702-1-jiayuan.chen@linux.dev>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260305073343.250702-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1vyELJ-00000000MfN-3cSS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.13]:52146
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 27
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNG+yeq2ExKMjnPK49bJ8wRUvwOMt11Cuys35KnQpqP/x5Dq4/tQ6nDT9TNR1AMbDSss/RieOIvuCpt6DfzJg4HdITRSs/ZbuLQxZ8z0OO3+RKjjojd3
 AJ5sw4amfm5ZAVp3KV/ONuRfD7co0CXbtphwV/frvXIMN70ogUOIfdzn5ljFbo2LWj2J/uYpf/tPz5DLG5pvppzfkqmEnG0Ix0Q=
X-Rspamd-Queue-Id: 4606A217849
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[embeddedor.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264518-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[embeddedor.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	HAS_X_SOURCE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_X_ANTIABUSE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gustavo@embeddedor.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[embeddedor.com:-];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[netdev,d5ace703ed883df56e42];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,embeddedor.com:mid]
X-Rspamd-Action: no action



On 3/5/26 16:33, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Syzbot reported a warning in u32_init_knode() [1].
> 
> Similar to commit 7cba18332e36 ("net: sched: cls_u32: Avoid memcpy()
> false-positive warning") which addressed the same issue in u32_change(),
> use unsafe_memcpy() in u32_init_knode() to work around the compiler's
> inability to see into composite flexible array structs.
> 
> This silences the false-positive reported by syzbot:
> 
>    memcpy: detected field-spanning write (size 32) of single field
>    "&new->sel" at net/sched/cls_u32.c:855 (size 16)
> 
> Since the memory is correctly allocated with kzalloc_flex() using
> s->nkeys, this is purely a false positive and does not need a Fixes tag.
> 
> [1] https://syzkaller.appspot.com/bug?extid=d5ace703ed883df56e42
> 
> Reported-by: syzbot+d5ace703ed883df56e42@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69a811b9.a70a0220.b118c.0019.GAE@google.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> Made-with: Cursor
> ---
>   net/sched/cls_u32.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 9241c025aa74..8f30cc82181d 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -852,7 +852,10 @@ static struct tc_u_knode *u32_init_knode(struct net *net, struct tcf_proto *tp,
>   	/* Similarly success statistics must be moved as pointers */
>   	new->pcpu_success = n->pcpu_success;
>   #endif
> -	memcpy(&new->sel, s, struct_size(s, keys, s->nkeys));
> +	unsafe_memcpy(&new->sel, s, struct_size(s, keys, s->nkeys),
> +		      /* A composite flex-array structure destination,
> +		       * which was correctly sized with kzalloc_flex(),
> +		       * above. */);
>   
>   	if (tcf_exts_init(&new->exts, net, TCA_U32_ACT, TCA_U32_POLICE)) {
>   		kfree(new);


