Return-Path: <netdev+bounces-283682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VJd3F72492lZlgIAu9opvQ
	(envelope-from <netdev+bounces-283682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 23:06:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1674B76A6
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 23:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0181F30063B8
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 21:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C69372EDB;
	Sun,  3 May 2026 21:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="sXR4SoyF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE5E40DFCE
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777842353; cv=none; b=HQFyIoiPfFibUr+tj5O/2ILf9gLksvcm773aN6ERqm3Is1amBUGuhkXW+h5D24EfCYU8VO0/FHh5blGVbg1FSk2fi/FTPDf3Wz0eEWPzM2xHaF+hqNVpnVZg0IEtVlBDkSLPxSo5d+l/+e6XQ+wr6875sLzOrCrMpK1U+dfYOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777842353; c=relaxed/simple;
	bh=siiICkEilXeXZ6kqJZEx2xDirx1jm8rHxq+Xeu9KKb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ha8dobP/c2s0efSIv7Gd+FdAwWT8TA2s3Tt0j98uMKZMNGjlI7oN/ETg5Aegbk0knJ3E61VQMB2SGJVxUNoPwt4bSgum5oYDELT5dmihZC4hvRHCGndghl+GK+GT7iTxGWZOOEwok0xJmcjvkTbLf/R+lu5JUZwFisXvyFoXr5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=sXR4SoyF; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2eadb000b8cso6564036eec.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 14:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777842350; x=1778447150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cb8DrgXDvbxUBa750BGI5RxPmIAQPhfI+ja95kvkQ64=;
        b=sXR4SoyFx3t6iTWJVuHd0hgBhPLfyOP/aH+NFWxZUUTVv6HyPdiwu2aFEunBA4wEl/
         Mt8yNlAvQuMo5i8soekMVn3/RRSRTphFUHWIK5gx335Uj92NjdFcgRHMy19aw3lpfoXm
         Wxs+iaWoHufTdEtAwBNWLL2yEp/bNwf0hEgVjzUVu/01R6mUdGlg1g/arCPqs/sEftSW
         HuMcpl9O39wjGKcXn0JZ6iKEdLYq0U6yp1P13zWAz/GvAb54WteABpJrp1PYBSi/VIrw
         bAmpUQvw611FhSs2FPWInkIKZSAFpk11DqZo0aEJy980R1AtaYoOiwg7yMF282NChAbN
         Ze3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777842350; x=1778447150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cb8DrgXDvbxUBa750BGI5RxPmIAQPhfI+ja95kvkQ64=;
        b=MaicCParv5LzGhHxZMDAZSDJYUzpa1vEjsCUjF++19Vp3gZGD2qaDoYaBazFLC1q9N
         QnJb17nRuYdPHiYsa9HB01ol1LK2t5sx5IRHS3P8ywbK8p51yRQfwMpp0lYNXC8Lnnrv
         lkWAibFJ0yp9fCsnFv+eaH1myvgEatBNKWSjEkGhc7Yyauo3LotZ2avymyjlR2NJ+wiU
         RPRpAMEGFaviys7EC91M2fqOjl5afIltPM/LU4BtKPe/AtZc/obBq7PhneTAlvrp+fQD
         tDtVUbQjLr2Au83h+ve3/NZdePNcSbORqLCv2dnssJbIvRwgG7JgjQbRM8AxKyjK72jO
         uavA==
X-Forwarded-Encrypted: i=1; AFNElJ8CrHiTjFTkNOc0S/jTx9waVlpMJ7VdOL2X5VIayKhlWRhJHwgGSq9umZuHaBVf6QNoqJqDJ5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXFlt95Np5V6UoZ9jocWNU/przfcpxOxUgkFSfHngYb6Jg3S1/
	rwtQNMeaN6j6Ij0fQE2ZTo2AuApLypUCLdw1+WnJMM1w79Q7eyx8Hs6qAJEIH4Lq6qo=
X-Gm-Gg: AeBDietVE+QupA17pUB3QdBK8oFRQwqFml1kMYRUhpQ6ntRrH3QwGIyzuNo5xovD1WK
	uQ1EAQ7uguhWcmbuI0EigD0TynXUxHB0XRuA6FtWG8yEeLtD9GW/H0F3ENkP/H4sP6Z3r5HXy70
	17Uhz4nvDV6MwR0EEm6OS78qMO27q+4hw16e16wG2I95Q1zuSrajCSjwG7C+1v8bVQO2t0AIm69
	kIE+UEWLyxiA5bCc5MX24xoYa6zA5KdtZ3kiXOCvVCaKaq0mZ8UBnvexPwKj68jWEy/1MwGD2vK
	ZamKBjxGNQpXksx1aci+/sNvCyfZMvMApRehoeopvSXMSnBXguM+jyXuhxgKMo1v8dz3jnXYbN0
	ak3551WjVN0G+x/zrPKVT3uYH+7AAjVeO64zaIsU3ubkTcQ2UPFz/vgPdVF8sgAzVddu6vrcC/W
	KOzg9zWsB7fBb7a+06yLLlif8eLtgD1z2N8agzCU6Ypv6yVQ==
X-Received: by 2002:a05:7300:6d21:b0:2da:1874:f39c with SMTP id 5a478bee46e88-2efb85af63dmr3276331eec.12.1777842350269;
        Sun, 03 May 2026 14:05:50 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee393578f1sm13787302eec.13.2026.05.03.14.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 14:05:50 -0700 (PDT)
Date: Sun, 3 May 2026 14:05:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: dsahern@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next 0/6] seg6: SRv6 Mobile User Plane (RFC
 9433)
Message-ID: <20260503140547.6d732f4b@phoenix.local>
In-Reply-To: <20260503153006.900533-1-y-kusakabe@bbsakura.net>
References: <20260503153006.900533-1-y-kusakabe@bbsakura.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0E1674B76A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283682-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[end.map:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ietf.org:url,phoenix.local:mid,networkplumber-org.20251104.gappssmtp.com:dkim]

On Mon,  4 May 2026 00:30:00 +0900
Yuya Kusakabe <yuya.kusakabe@gmail.com> wrote:

> From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
> 
> This series adds the iproute2 frontend for the SRv6 Mobile User Plane
> (MUP) endpoint behaviors of RFC 9433.  It is sent in parallel with the
> matching kernel net-next series; each commit here is self-contained
> and brings in the seg6local UAPI bits it needs from the in-progress
> kernel UAPI header (include/uapi/linux/seg6_local.h):
> 
>   Section 6.2  End.MAP
>   Section 6.3  End.M.GTP6.D
>   Section 6.4  End.M.GTP6.D.Di
>   Section 6.5  End.M.GTP6.E
>   Section 6.6  End.M.GTP4.E
>   Section 6.7  H.M.GTP4.D
> 
> The series adds these seg6local CLI keywords:
> 
>   src                  IPv6 source-address template
>   v4_mask_len          length of the IPv4 DA portion of the SID, in
>                        bits (1..32)
>   sr_prefix_len        locator length of the egress End.M.GTP*.E SID,
>                        in bits (1..88, leaving 40 bits for the
>                        Args.Mob.Session field)
>   v6_src_prefix_len    Source UPF Prefix length P in the IPv6 SA
>                        template (1..127, defaults to 64); requires
>                        P + v4_mask_len <= 128
>   pdu_type             GTP-U PDU Session Container PDU Type (3GPP
>                        TS 38.415 Section 5.5.2): downlink|dl|uplink|ul
>                        or 0..15.  When omitted, the egress emits a
>                        short GTPv1-U header (no PDU Session Container)
>                        regardless of the QFI in the SID; 5G N3
>                        deployments must set pdu_type explicitly.
> 
> A small per-action attribute validator (introduced in patch 1 and
> extended by each subsequent behavior) rejects obvious typos in the
> seg6local block at the userspace layer instead of leaving the
> operator with an opaque kernel EINVAL.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc9433
> 
> Yuya Kusakabe (6):
>   seg6: add support for the End.MAP behavior
>   seg6: add support for the End.M.GTP4.E behavior
>   seg6: add support for the End.M.GTP6.E behavior
>   seg6: add support for the End.M.GTP6.D behavior
>   seg6: add support for the End.M.GTP6.D.Di behavior
>   seg6: add support for the H.M.GTP4.D behavior
> 
>  include/uapi/linux/seg6_local.h |  17 +++
>  ip/ip_common.h                  |   2 +-
>  ip/ipnexthop.c                  |   2 +-
>  ip/iproute.c                    |  14 +-
>  ip/iproute_lwtunnel.c           | 263 +++++++++++++++++++++++++++++++-
>  man/man8/ip-route.8.in          | 154 +++++++++++++++++++
>  6 files changed, 442 insertions(+), 10 deletions(-)
> 
> 
> base-commit: 4f5de57e2ff11a5925dacdf3deeeabee7ba9502a

Automated AI review of iproute2 is not setup yet, but manual run showed:

Subject: Re: [PATCH iproute2-next v1 RESEND 1/6] seg6: add support for the End.MAP behavior

On Mon, 4 May 2026, Yuya Kusakabe wrote:

> +static void seg6local_action_check_attrs(int action, int nh6_ok)
> +{
> +	switch (action) {
> +	case SEG6_LOCAL_ACTION_END_MAP:
> +		if (!nh6_ok)
> +			invarg("End.MAP requires \"nh6\"\n", "");
> +		break;
> +	}
> +}

The invarg() helper expects the invalid argument string as its second parameter,
not an empty string. This should be:

			invarg("End.MAP requires \"nh6\"", argv_value);

However, since this is a validation function called after parsing and doesn't have
access to argv, a different error reporting approach is needed. Consider using
fprintf(stderr, ...) directly or restructuring to keep the argv value available.

This same issue appears in all patches in this series whenever invarg() is called
from seg6local_action_check_attrs():
- Patch 1: End.MAP validation
- Patch 2: End.M.GTP4.E validation (multiple instances)
- Patch 3: End.M.GTP6.E validation
- Patch 4: End.M.GTP6.D validation
- Patch 5: End.M.GTP6.D.Di validation
- Patch 6: H.M.GTP4.D validation

The rest of the implementation looks good:
- Correctly uses strcmp() instead of matches() for new argument parsing
- Properly uses print_XXX() helpers with PRINT_ANY for JSON output
- Includes proper documentation updates

Please fix the invarg() usage throughout the series.

