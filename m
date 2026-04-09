Return-Path: <netdev+bounces-277153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NFkNiwk2Gm9YggAu9opvQ
	(envelope-from <netdev+bounces-277153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 00:11:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DB43D0286
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 00:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D8513025722
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 22:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7BF38756E;
	Thu,  9 Apr 2026 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="OD2OYFr0"
X-Original-To: netdev@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE62C387364
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775772661; cv=none; b=SEDXFjPrIx/prXJ+i/oUuX54NIWb/C3jVKga01uqsnvHY9rMd7yzqHsFM6fo2pathkFuCadaSWvi89n2LWPPZ/Mg5qoIHp2+M+xqS1lMhrFjhqU2SaMhawZ3O6nyY85QV6gYt8SHeh31Aw3dGMerwLQrM/nFGg7k/9l2J+Y35QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775772661; c=relaxed/simple;
	bh=wo6Ox7iCVjKYu5cSTs6fnMoWweBLD66PN67ebOZ9Rlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIRguVKv74KAz8IG4/SnWjVOAi4aYuK9eZUW6QnKSpVmSFDczR2FxzaK8CT3AuPUbkfc7qVVMfxhrhMTEB8oDmgghhDeC5f1CQi5WEZ3W4OLlhmyQZtvcJEa10wTawYvMHHu6Igeu1flpzeQKbq9y20VtOoNEUKmC4bGYcikFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=OD2OYFr0; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id Asw0wK6Hh4RkpAxaVwjgM1; Thu, 09 Apr 2026 22:10:59 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id AxaUwO2jSOPYdAxaUwnrXq; Thu, 09 Apr 2026 22:10:58 +0000
X-Authority-Analysis: v=2.4 cv=QbNmvtbv c=1 sm=1 tr=0 ts=69d823f2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=chC0KcwHAXg1M6QkddG+Hg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=QSUYj3f-MeYbdhfgnocA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wpf1yAGrWWdCI706JaYjI24hP31WYUmdkcxek4LzYwI=; b=OD2OYFr0F2IVAr8xatAm2K4sjj
	WFHM4NVQEne4vc54doaNgD1aSgnW0LbwTnaQp4BBXuxotMVvGIASDxK4y6APSOcNLrEpfyIw+VJKa
	jC0U7+4q52sGkjLIbL1rwR70ByeRCik1Q9o68lcp/dqfQ+5y4/yzlHyGrTFjN11gJlfZYTJSam2cY
	LVC7FSh1jd+9E2R+8M5F+use96KrCp2pRi8xxSCpicwBdZPVZjFggpLzQjMljyKu+qMM1rNL8puPX
	xVJF9yPyx8RbS8WezciZP8QzFz4gQ60ziuEbmVm8yzph9aPWfIlniluha1p/cI+DbCGHzTouDCFue
	MwANqgbQ==;
Received: from [177.238.18.219] (port=33830 helo=[192.168.0.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1wAxa4-00000003KKH-30tW;
	Thu, 09 Apr 2026 17:10:32 -0500
Message-ID: <96b116e4-d91d-456a-9a08-fb3de4822a62@embeddedor.com>
Date: Thu, 9 Apr 2026 16:09:21 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] netfilter: x_tables: Avoid a couple
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kees Cook <kees@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <adgL5wPm9VpaV3MO@kspp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <adgL5wPm9VpaV3MO@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.18.219
X-Source-L: No
X-Exim-ID: 1wAxa4-00000003KKH-30tW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.104]) [177.238.18.219]:33830
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCwNw0Pgy+onizKqfzmdQL5q+8umotvOX2utu+9FVi78BHpBxajRi3GczpAdYegfm8hRw4DAAd5QgXMgXI6ZpMRSUzGDBHkGq/tALGn68KnJ6aU8jBF+
 ZuO7lwP4IUorFjmcO152sufqhyeZXZ8FoY5bruOExzGmwWvlRusnVfNR9u4OOLuZSBkbpkz4MS86cVRavwEU/i+yJLdV3Avtn4s=
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[embeddedor.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277153-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[embeddedor.com];
	HAS_X_SOURCE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[embeddedor.com:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gustavo@embeddedor.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54DB43D0286
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

BTW folks,

We can use the TRAILING_OVERLAP() helper and address these warnings with
the following patch instead:

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index b39017c80548..9dd5957d9ed4 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -819,13 +819,15 @@ EXPORT_SYMBOL_GPL(xt_compat_match_to_user);

  /* non-compat version may have padding after verdict */
  struct compat_xt_standard_target {
-       struct compat_xt_entry_target t;
-       compat_uint_t verdict;
+       TRAILING_OVERLAP(struct compat_xt_entry_target, t, data,
+               compat_uint_t verdict;
+       );
  };

  struct compat_xt_error_target {
-       struct compat_xt_entry_target t;
-       char errorname[XT_FUNCTION_MAXNAMELEN];
+       TRAILING_OVERLAP(struct compat_xt_entry_target, t, data,
+               char errorname[XT_FUNCTION_MAXNAMELEN];
+       );
  };


This helper creates a union between a flexible-array member (FAM)
and a set of members that would otherwise follow it. This overlays
the trailing members onto the FAM while preserving the original
memory layout. It was created to address exactly these sorts of
issues where flexible-array members end up embedded in the middle
of structs.

You tell me what you prefer.

Thanks
-Gustavo

On 4/9/26 14:28, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> struct compat_xt_standard_target and struct compat_xt_error_target are
> only used in xt_compat_check_entry_offsets(). Remove these structs and
> instead define the same memory layout on the stack via flexible struct
> compat_xt_entry_target and DEFINE_RAW_FLEX(). Adjust the rest of the
> code accordingly.
> 
> With these changes, fix the following warnings:
> 
> 1 net/netfilter/x_tables.c:816:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 1 net/netfilter/x_tables.c:811:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>   - Update verdict after (compat_uint_t *)st->data;
> 
> v1:
>   - Link: https://lore.kernel.org/linux-hardening/adbIKC0cZcK7VcCF@kspp/
> 
>   net/netfilter/x_tables.c | 31 ++++++++++++++-----------------
>   1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
> index b39017c80548..746012196d83 100644
> --- a/net/netfilter/x_tables.c
> +++ b/net/netfilter/x_tables.c
> @@ -817,17 +817,6 @@ int xt_compat_match_to_user(const struct xt_entry_match *m,
>   }
>   EXPORT_SYMBOL_GPL(xt_compat_match_to_user);
>   
> -/* non-compat version may have padding after verdict */
> -struct compat_xt_standard_target {
> -	struct compat_xt_entry_target t;
> -	compat_uint_t verdict;
> -};
> -
> -struct compat_xt_error_target {
> -	struct compat_xt_entry_target t;
> -	char errorname[XT_FUNCTION_MAXNAMELEN];
> -};
> -
>   int xt_compat_check_entry_offsets(const void *base, const char *elems,
>   				  unsigned int target_offset,
>   				  unsigned int next_offset)
> @@ -850,18 +839,26 @@ int xt_compat_check_entry_offsets(const void *base, const char *elems,
>   		return -EINVAL;
>   
>   	if (strcmp(t->u.user.name, XT_STANDARD_TARGET) == 0) {
> -		const struct compat_xt_standard_target *st = (const void *)t;
> +		DEFINE_RAW_FLEX(const struct compat_xt_entry_target, st, data,
> +				sizeof(compat_uint_t));
> +		compat_uint_t *verdict;
>   
> -		if (COMPAT_XT_ALIGN(target_offset + sizeof(*st)) != next_offset)
> +		st = (const void *)t;
> +		verdict = (compat_uint_t *)st->data;
> +
> +		if (COMPAT_XT_ALIGN(target_offset + __struct_size(st)) !=
> +				next_offset)
>   			return -EINVAL;
>   
> -		if (!verdict_ok(st->verdict))
> +		if (!verdict_ok(*verdict))
>   			return -EINVAL;
>   	} else if (strcmp(t->u.user.name, XT_ERROR_TARGET) == 0) {
> -		const struct compat_xt_error_target *et = (const void *)t;
> +		DEFINE_RAW_FLEX(const struct compat_xt_entry_target, et, data,
> +				XT_FUNCTION_MAXNAMELEN);
> +		et = (const void *)t;
>   
> -		if (!error_tg_ok(t->u.target_size, sizeof(*et),
> -				 et->errorname, sizeof(et->errorname)))
> +		if (!error_tg_ok(t->u.target_size, __struct_size(et),
> +				 et->data, __member_size(et->data)))
>   			return -EINVAL;
>   	}
>   


