Return-Path: <netdev+bounces-260092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPC1Ovh2nGlfIAQAu9opvQ
	(envelope-from <netdev+bounces-260092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:49:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6529817909A
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA8AE3111975
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45162FD1B6;
	Mon, 23 Feb 2026 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hDKV/xPt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3972F25F9
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861373; cv=pass; b=GUdcuohusLmcKrRbhrgGpy/vQZOcMx8D3wVRpxk2OY4GWxmkIcWmzPfettAFmCIC47LSETU7SVcF5bsg7S4eowAa5odMdM4F/Fz87WWpTDy7gANC4AMhUne5kydmcYhSdNi/+PaUAf47aikkGLNLHQEujaByBkFD2cDb11wBiTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861373; c=relaxed/simple;
	bh=VaD1hP3qDyWfmRVMvzzpClAqfvsg9B8+/eKP6zQRvcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PT2P1hSpNviZhUMdTGL9ExIN6EOC5UNOJ8PbZrnOPs4Q/wPmOr2ETt8ssVWrw7f/3Ee0GMArYfAuEn2cz4QhcIBMF/rlkt88CmKZnZEtCBFtLTkAwHE3Gzuag3yrxUe2v3VnLkxztXW4XHADDJ3hqXz1VC3OQ25aWevFrxQluFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hDKV/xPt; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89549b2f538so56432436d6.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 07:42:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771861371; cv=none;
        d=google.com; s=arc-20240605;
        b=RWX4VtEITMJMHxKL/Ve3rfn2rvWWWNDgq1sLQxnnXSgWYoaHYWKFR9FD0T0aXqf9xb
         1CsX1PU5MeVX/tFbmL/IIExX/JGCMDjDpYMq7DecjDRVsdARRmCl1v073tZoTz4q9ElO
         s7qAjx61kzKoerTlx0CeIrQsxM+io6g3JVHVo1XybOMxtX7Wgjfd7GK61DqUKn0ebAEN
         8/MFCskSPkcBWQIIdX+/qIaGD8hg5vekHCH9riK2Y/TwDTIDiU2MD100FMlKyOocKguk
         Im7rkPVdN31Sfz4rkcHDO80Erz24YYjZCJWWe6UxSSFCG+DLtxhWJKKxyNPj+nPrIrix
         UTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XEz6JL0M2Q9E47FRFCu4UESN+HIEmZm2RKZGVVNL4pI=;
        fh=e6GN0q4BNkDZ/DQnlxu/Nm/Bijr+2KRRzpoEfhXyD3c=;
        b=VauHEChWDFXmgDQgI9Yb/7/SceD6IqeZSncZtlvVEMVD9BVfWNTyaDdDWf9Di/CqmH
         HJKvO8/JDJwldnq8YuSMACJf03a25Qb9dJBIHpNCjAFvGQ7plSrRISnXef6bcCwsX7Zr
         auHBGnHVHvln56Nhj9y4p9RLMmVx7QQFNRZqOKXoUl7drvcDNJHU44RcwFpRPTstYHZs
         26qVlVTtSDRAqTqm0nmN/6v2TzwspJZ+psVMGzb/6mb6gkPr1BSSsouhrbxTbbqGh04C
         g5bP/3FUZUA60jbWthwvyxpG2iLKEvvBEfpycna+Cu77ZuV7qgzriKp+1udfc/lRVJji
         cPzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771861371; x=1772466171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEz6JL0M2Q9E47FRFCu4UESN+HIEmZm2RKZGVVNL4pI=;
        b=hDKV/xPtlXnylWLq7xG1EY4A7G89/rWKHj0zJEi4DLrlOpzSng8vAI3ZL4jx/se4ma
         YPBOu/j63Ggb7Iivo677Zxa5VOFim/w4B96BQSDFOlfMzuo06Ltnppq5dnZhAwLEuC/X
         DKNGykq1KTi87Stp1qNTqODXQVRMZWTR1b9SLSWLBbykHfHPxFX0TM2Ub7NdHoOeu+uU
         Kz4ksufl5I6pV3ZyqgaUdcWvdE2K4vWMqhBMBWOUmTelx6LvY+rXOcGxfrOcuRkzTMZI
         +ukA90EquzRN/8VxDPGTHSxpuGkYskuMvcLLJRIpmmotB0fB+Tw1FFI17KdrmOwjZXEF
         4+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771861371; x=1772466171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XEz6JL0M2Q9E47FRFCu4UESN+HIEmZm2RKZGVVNL4pI=;
        b=fUqTZw/2IZ33xJOI6iQfytqQMjhTf9WJb+abTaVdScssCOKZTJxXswhzEZXiVCfBwn
         OiXvu4KxaCJyYOIGytLc0H7nLAxNf7dMnYcyFvvzcw3x6rcgzmbLhhjXJahd8jE8qvNI
         3+a6k8w1wYBI9E3U+5btaj764OgSfvDRccLPDCqEPXNv0uRZjGRZIJPjOJF1BI22e3X2
         OhDmpNPAavpdS4vzPD1Qm5usjSYyS14s92aduLlH6lt65GXdewnh33w7MmrkBdVAeKj3
         rYCNo5ftsTkoySnO/gRw+DkRrLfQObKVWpm0+AHg+gr1hMl/556+dbz9OQgD0OvDS5Fq
         88Ig==
X-Gm-Message-State: AOJu0Yy6yVg537QHTacqZJvzJBN/KRaWopCjugRaZiDzej72iWOio6UK
	vNwqsvM9YFuw/Wc30OMvp8ZYaQToHhgVXwNsxX7AYlywR0bvBUT9H+zZvjlrCF57gKPyl7LJfSb
	QCTR6HsaPzkIwbVa9pLRMuEokkge9WBsA5Xw2abXl
X-Gm-Gg: ATEYQzzFHKU6W5J+Ww6a5Oktjf2CmwB6R0H1ZAEeRg7MUGfPZizdaituc6bZdxkoHdZ
	WMIImzOqfE85+ZIAX3scWu5pA/tNkLtow1YrfRWQ8Geoqm8+diyiUp5/ki5pvSjbfQqCToRC3rN
	t07NOTfUG9Ec8hn1SCD6di8aSLcEdllzrIKCQT05VMUv/AxlMVfDPiirn/T8wu5yoMwinf/rxRE
	XB8TGxdo9sNHTWajXLN6x5YZovZpKxoUIIL2PPgMpGDj1kOtnezKzFQh1EcVltFP71uUsNp6NjZ
	LcpNLLM=
X-Received: by 2002:a05:6214:2683:b0:897:30b:e1f4 with SMTP id
 6a1803df08f44-89979c5548emr139635436d6.13.1771861370492; Mon, 23 Feb 2026
 07:42:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223151918.31965-1-fmancera@suse.de>
In-Reply-To: <20260223151918.31965-1-fmancera@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Feb 2026 16:42:39 +0100
X-Gm-Features: AaiRm53cxH1NY1tm_hmzk2-IRrV1HzXetN3mjL38-QNchHqkakyWqoo9cDDGnMM
Message-ID: <CANn89iLHNrikOivuKDbBHaZGY-OPD124_JoLthiv49G7Hhm7UA@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: discard fragment queue if middle fragment
 is not 8 bytes aligned
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, dsahern@kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-260092-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 6529817909A
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 4:19=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> Currently the kernel IPv6 implementation is not dicarding the fragment
> queue upon receiving a IPv6 fragment that is not 8 bytes aligned. It
> relies on queue expiration to free the queue.
>
> While RFC 8200 section 4.5 does not explicitly mention that the rest of
> fragments must be discarded, it does not make sense to keep them. The
> parameter problem message is sent regardless that. In addition, if the
> sender is able to re-compose the datagram so it is 8 bytes aligned it
> would qualify as a new whole datagram not fitting into the same fragment
> queue.
>
> The sooner we can free resources during reassembly, the better.

Ok, but there is another situation we could do the same ?

 if ((unsigned int)end > IPV6_MAXPLEN) {
   ...
   return -1;
}



>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  net/ipv6/reassembly.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
> index 25ec8001898d..8b0bc0ba56f4 100644
> --- a/net/ipv6/reassembly.c
> +++ b/net/ipv6/reassembly.c
> @@ -163,6 +163,9 @@ static int ip6_frag_queue(struct net *net,
>                          * this case. -DaveM
>                          */
>                         *prob_offset =3D offsetof(struct ipv6hdr, payload=
_len);
> +                       inet_frag_kill(&fq->q, refs);
> +                       __IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
> +                                       IPSTATS_MIB_REASMFAILS);
>                         return -1;
>                 }
>                 if (end > fq->q.len) {
> --
> 2.53.0
>

