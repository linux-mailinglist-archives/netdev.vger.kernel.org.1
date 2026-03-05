Return-Path: <netdev+bounces-264516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEIlCh3WqWnbFwEAu9opvQ
	(envelope-from <netdev+bounces-264516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 20:14:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCCE21752A
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 20:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 636ED3018744
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 19:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFF23033E2;
	Thu,  5 Mar 2026 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="hYrt5u4P"
X-Original-To: netdev@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3E1F1534
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738073; cv=none; b=UL538leI4RFV5xGqB3UwIZAa24QiPK56NwrY/5xb5unc3mM+majxUiOHxBxseeFgZh3pRxwAeAns4bcVGTWqxKNp7W0Z2JWAsDDsaACc88yhhvvgfXQ/8YuTQ1fen0c9mBfZo4pHlLszQXPbgiAeeOel2vlglFK+rMeXMb/2L74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738073; c=relaxed/simple;
	bh=qRdDrBna4a6872YMyXijGc872wYwYrXblTPPs70KtTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGcuJ4QvI274n4XR9T72KvKZWawmdslKAbR4BYk/ztjWvCRYnbwSqLvUaQ3/7NgRf2vBMwM6eFyIr2rter4vTxQeXrvgo0QfkINIR09UO7WFkY93evdvBCT7++VThpcs8M1yWG+GzUzbvg69IEnfC+LCagT214nj0YVQoChpLH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=hYrt5u4P; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id yC3OvLLQcaPqLyE9Xv225x; Thu, 05 Mar 2026 19:14:31 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id yE9Xv2DEnh8QWyE9XvgKj0; Thu, 05 Mar 2026 19:14:31 +0000
X-Authority-Analysis: v=2.4 cv=Mcdsu4/f c=1 sm=1 tr=0 ts=69a9d617
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=edf1wS77AAAA:8
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=J2gJbEVsAAAA:8 a=hSkVLCK3AAAA:8
 a=Yx1WBRiMjIbWHXwVVgIA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=Bt_igOxda4ASFyQEjNxY:22 a=cQPPKAXgyycSBL8etih5:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sZMfNUjL8QEWNequUGC+4j4wQXCEXyFRudo0qIRAqyA=; b=hYrt5u4PV4omYCa9x78WfqR6GG
	nMIcpVmxrwAIQIqFlVCIF6Myd7FsXCaFpgFsxw72PGhka6kdfBfdb4c3Lq87pgsACnCc+Z/e0+jkf
	FhLPozGFY9dJ2dQSe9RGerkKYEfGkuiIL1AKEPI1T6vK0SUugSamrcBfd3UG8h1omGzxsBrCVv4Ml
	m1MszpCwWogM/232Q3SUNi90/NbawmKq2Ij5n9KqKn3FqL42u3ePiDtfDGDhRNF9sBRiXGN47ME33
	Y8+6Ge+JeM8ho90m+SFgxqeDOIGzOB2ihBhAkE6vShjDT04foSkZCte7WzyF9rkkqLdLRf07g6/yR
	zmdQFlSA==;
Received: from [177.238.16.13] (port=41596 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vyE9V-000000008gQ-2btz;
	Thu, 05 Mar 2026 13:14:30 -0600
Message-ID: <7c33220b-df94-429c-9cd5-fd2b7d7d1add@embeddedor.com>
Date: Thu, 5 Mar 2026 13:13:45 +0900
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
 <fef6bae161f319a188b5b6f157b33498a463e3e6@linux.dev>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <fef6bae161f319a188b5b6f157b33498a463e3e6@linux.dev>
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
X-Exim-ID: 1vyE9V-000000008gQ-2btz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.13]:41596
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGj2/TIGCvSdVv5KKyptqfEcJCIoAH2LM3Fn736aAhZTrTZCZOPSmIaxVaopREeWTpdLwHCXIa11Ua/e/h8qcnDlGCdZ2YNIH9yLzg1kS9m7KV21pnth
 Tn2DlQdGOJ8AlheJ3pWKXTFIxmtT7F8/HNy5S/GaTV0kWsZpR+BiIojthc/94HIurvZ8+7zAMdkqofLW6qJxF8er3RVt2O9+VyY=
X-Rspamd-Queue-Id: 0FCCE21752A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[embeddedor.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264516-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[embeddedor.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	HAS_X_SOURCE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_X_ANTIABUSE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gustavo@embeddedor.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[embeddedor.com:-];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev,d5ace703ed883df56e42];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Action: no action



On 3/5/26 17:09, Jiayuan Chen wrote:
> March 5, 2026 at 15:33, "Jiayuan Chen" <jiayuan.chen@linux.dev mailto:jiayuan.chen@linux.dev?to=%22Jiayuan%20Chen%22%20%3Cjiayuan.chen%40linux.dev%3E > wrote:
> 
> 
>>
>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>>
>> Syzbot reported a warning in u32_init_knode() [1].
>>
>> Similar to commit 7cba18332e36 ("net: sched: cls_u32: Avoid memcpy()
>> false-positive warning") which addressed the same issue in u32_change(),
>> use unsafe_memcpy() in u32_init_knode() to work around the compiler's
>> inability to see into composite flexible array structs.
>>
>> This silences the false-positive reported by syzbot:
>>
>>   memcpy: detected field-spanning write (size 32) of single field
>>   "&new->sel" at net/sched/cls_u32.c:855 (size 16)
>>
>> Since the memory is correctly allocated with kzalloc_flex() using
>> s->nkeys, this is purely a false positive and does not need a Fixes tag.
>>
>> [1] https://syzkaller.appspot.com/bug?extid=d5ace703ed883df56e42
>>
>> Reported-by: syzbot+d5ace703ed883df56e42@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/69a811b9.a70a0220.b118c.0019.GAE@google.com/T/
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
>> Made-with: Cursor
>> ---
>>   net/sched/cls_u32.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
>> index 9241c025aa74..8f30cc82181d 100644
>> --- a/net/sched/cls_u32.c
>> +++ b/net/sched/cls_u32.c
>> @@ -852,7 +852,10 @@ static struct tc_u_knode *u32_init_knode(struct net *net, struct tcf_proto *tp,
>>   /* Similarly success statistics must be moved as pointers */
>>   new->pcpu_success = n->pcpu_success;
>>   #endif
>> - memcpy(&new->sel, s, struct_size(s, keys, s->nkeys));
>> + unsafe_memcpy(&new->sel, s, struct_size(s, keys, s->nkeys),
>> + /* A composite flex-array structure destination,
>> + * which was correctly sized with kzalloc_flex(),
>> + * above. */);
> 
> 
> 
> I'm thinking whether it's more appropriate:
> 
> new->sel.hdr = s->hdr;
> memcpy(new->sel.keys, s->keys, flex_array_size(s, keys, s->nkeys));

I think unsafe_memcpy() is "better" in this case, as it will mark code
that could be updated/reviewed once the compiler can correctly see into
composite flexible structures in the future.

-Gustavo

> 
>>   if (tcf_exts_init(&new->exts, net, TCA_U32_ACT, TCA_U32_POLICE)) {
>>   kfree(new);
>> -- 
>> 2.43.0
>>
> 


