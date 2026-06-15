Return-Path: <netdev+bounces-299496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gBtgJJcXMGp2NQUAu9opvQ
	(envelope-from <netdev+bounces-299496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:17:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA18C6878FF
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:17:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=klCVecqF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299496-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299496-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4966431519A4
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E8A40148A;
	Mon, 15 Jun 2026 15:13:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788623FFAA3
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:13:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536424; cv=pass; b=ucQVPiiH0g+NpyEmxBLCsrf22OHsM/KZGNCphfYHCkZ28nI4lRqbNYchDuRj8YCbB1yx6XDBLwgKM8WGR8/CuRm7Vecb+VTyBrTyHaBQH/ZNnmboG0ZQ2sXG/m6iRpv983toNwld06zH5xSNtfRTPVy+3JEPTZX0P26QCoAUyTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536424; c=relaxed/simple;
	bh=L4tIKHRAfazrZyHDE5HnHBrUENsIOAsCNzBSEuVMqj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDmRuWk+W5RE2ECeWYX62ioO358K7Bn9yp/71TthaTojUhqjvJT7eTnZeTXq0eJ/s7HAazUK1bPE6nGxEZTY3F/1tdCwb+EbcJew6/KordtzF6ORFKWzlVRq2O6IXQDw3FX0CE9VXdUdjlYPvigeJot1+kvhCEYWpUNlVjWe6fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klCVecqF; arc=pass smtp.client-ip=209.85.167.177
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-48611ccd5aeso2182525b6e.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 08:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781536422; cv=none;
        d=google.com; s=arc-20240605;
        b=Vwxg7xoyUYn2Vo0o42BjLMkmcV2KILhfnU0sFpfYo5kWuaKgZMwuNq6BpS4LSdw365
         RpyYFbmhURXRGwuBA0Mvn7ZANHL4rmIg+sCfp7ET+/XlPheqDENFToaZIQeWOkIPJbXM
         wgm5Zv4sxHdcUDUY+/F4WxMZ2CulRQHxXhQGe5RNJNbqQLEPS7QWK0sGQhFHt9yAz4Mf
         8ds8mZytJ7aaTShOUr0qp7zNgJyMRwjdzoUelzTvgbJCpk0KmKjfa2Hy4bOohMRvKWRY
         Fmn7mbWD3cemJBHtzq2+vwGKFxj+QKUUIOMRqLzHWS22XhhE4+kX+ydXJ/cToq/ncI92
         +0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4j08gAASoAIIOjoBrWRHUuNwjjxy9tWTzqArgJT6pIw=;
        fh=z/1+9jXzMQFy4dx0UtUy+M7asxBEcc0IfesIrm5g6A8=;
        b=DcGeC97vos64A1w9SVWSILs3M/09req5Z59xwNHCzZTk8ECSLCN/YHa4mz6kGKOpxs
         AscM6Euq757WRoayR5rL+vgFlc3nwyHplB2uH0uHibDQUabNbiEqgZvXR27HL9eJmr4g
         QMzFNyICod5OnYLxqFu8fefkpYdGGfrfBcWx1m09ODJPEQiXRuquNqqa7k+03HF3wOB9
         xagXLqSXYobvMmu+pN+dRIBsX/JdMyssaY+qHc0gmc3W7yj2to1xrXjAxAfvprIOh+46
         +zFBV5l4HRRaVBJIvTZ9aaGcZ8tn42GI1D1w5gMDs7sPMbi6iVtQTaSdDC7gw1VpDrsQ
         KmPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781536422; x=1782141222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4j08gAASoAIIOjoBrWRHUuNwjjxy9tWTzqArgJT6pIw=;
        b=klCVecqFJEx1WKF3malLFeirvEemPnW1lTx6wg49mWAkUqGvuFnG+drMp4vG3CVWFc
         /99x/p9vYADv2Zk3Y+bw3czv582di4l/gVOhehothoN/6VVGLT5Ywkie7tlTEagm4Dd7
         BPGY3OCLlPz8ManOMU5Mru9sn6piXrVU8Cei1Rxz9jrF+aelR78paMkMGsATea1kWRIP
         pKgmR02Pc4qNNqJJy/fHQhq0pHSeqZQkPhEX08NRHQpULKqu3ZSixRi2DnCRS8uOZFDl
         qlIs+1FfqPDvCAJhs9vP5dCUK73kt7Ld9My7QkG6HQefkI8aIRXMDKbg+NrAufF+U8Mt
         6bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781536422; x=1782141222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4j08gAASoAIIOjoBrWRHUuNwjjxy9tWTzqArgJT6pIw=;
        b=Pfqsc24oFHyVjlLl+5/q/uFUKUdPvs/nzwc6224DCBOLIKJyM5NRZUOdtIgEsiywW/
         wTUeVlRtzUY/gnSa6CrRrcmWWfHE2BKBkiYKRmLO3dNrfh1w5FursyClPWLKCC0Z2TG6
         t6TGDMqY3EusR2B17Dl6y/J0LEJuEWX8CJy4rXcSVjFPyoZCVHO0NkUrSrG15JkRVE8J
         AsbK1Gsfh55Mrcnpf/wdW9qtzZhbqG1N3Cx4QVRaxjC59Bz7ZAD3oMcfwlUYAePv6RA2
         KX/RxnwMYoelzdxc50UFZ9QSIpPCVG7rFrz1jOI2vPPuL1F5VZxDLTfGPPnU2MgC/JSv
         NzHQ==
X-Gm-Message-State: AOJu0Yxw+jeyIDjWkv7gpg6Y6mO8HsFx+/2/zCprDKTpbnuYdI1t6EzX
	uyBvXF1oRFX3NF9nOG32lHOdLn2ay6OQpjlK+yRKZFUMDqQORcYx3cNx6gIQyReH2ixndWyAO/G
	Qw2y2pPoJaIDOKv4vod2OvCnEPevlbjA=
X-Gm-Gg: Acq92OG/N5ZDdK93TrbGEKj3jHHr166oS2tbeHnURaQ2Sr6D1MeJXRXPC4YCRLrOOTG
	ew7SRFzN/7GUsl8stlUvosKYdNQo7336h7YHCjaFn2HEJ8CdenWWTHjdKjn3ImYq/9VvaPBw/61
	e8icIVs6KdxxAyqRkwEwjEHZdvXp8Qlia97LI/0hwCfPEn8iNA2CzndevSWsk5qM60hapIc1u6R
	Xxs8lYy8keLq5hPwjSXCRiyhA8w2w3mjLeqWT48c5tftLeweSJwiJzpkm+9OukTyTR+OatQxOff
	ctm5J7Qg
X-Received: by 2002:a05:6808:118e:b0:47c:7c7c:c792 with SMTP id
 5614622812f47-4872f2e1310mr10060611b6e.7.1781536422295; Mon, 15 Jun 2026
 08:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614155539.3106537-1-michael.bommarito@gmail.com>
In-Reply-To: <20260614155539.3106537-1-michael.bommarito@gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 16 Jun 2026 00:13:30 +0900
X-Gm-Features: AVVi8Cdz9OPjeUk60IfKuJwuj6m_-h0E1W3IpinkdbWOFkEDpOHZhrMw-UpQsnM
Message-ID: <CAMArcTWCg4x1bxrzr+XHc_FqbzJELCMu+tE=x8Jhewgr-_A3Rw@mail.gmail.com>
Subject: Re: [PATCH] amt: don't read the IP source address from a reallocated
 skb header
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299496-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ap420073@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ap420073@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA18C6878FF

On Mon, Jun 15, 2026 at 12:56=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>

Hi Michael,
Thanks a lot for your work!

> amt_update_handler() caches iph =3D ip_hdr(skb) and then calls
> pskb_may_pull(). pskb_may_pull() can reallocate the skb head: the new
> head is allocated and the old one is freed. The cached iph is not
> refreshed, so the following tunnel lookup reads iph->saddr from the
> freed head. On an AMT relay this lookup runs for every incoming
> membership update, before the update's nonce and response MAC are
> validated.
>
> The sibling handlers amt_multicast_data_handler() and
> amt_membership_query_handler() re-read ip_hdr() after the pull and are
> not affected; only amt_update_handler() keeps the pre-pull pointer.
>
> Snapshot the source address before the pulls and match against the
> snapshot.
>
> The stale read was confirmed by instrumentation rather than a sanitizer:
> after the head is reallocated the comparison reads from the freed old
> head. KASAN does not flag it because the skb head is released through
> the page-fragment free path, which is not poisoned on free.
>
> Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
> Cc: stable@vger.kernel.org # v5.16+
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Thanks for the fix.
Please tag this as [PATCH net] in the subject, since it's a bug fix:
[PATCH net] amt: don't read the IP source address from a reallocated skb he=
ader

You can drop the Cc: stable.
The Fixes: tag is enough for the stable backport process to pick it up.
Please send a v2 with the above changes. You can carry my ack:
Acked-by: Taehee Yoo <ap420073@gmail.com>

Thank you so much!
Taehee Yoo

> ---
> Confirmed on x86_64 by instrumenting the comparison: with the update
> packet built so the first pskb_may_pull() reallocates the head (it pulls
> bytes out of a page fragment with no tailroom), the read runs against
> the freed old head -- the head pointer moves and the old page's refcount
> is 0. Neither generic KASAN nor arm64 HW-tag KASAN reports it: page-
> fragment frees are not synchronously poisoned, and under MTE the freed
> page keeps a tag matching the stale pointer, so this class of stale-
> header read escapes the usual fuzzing oracles. On a live relay the freed
> head is also exposed to reuse by later skb allocations.
>
>   amtdbg: cmp reads iph=3D...e000 (skb->head=3D...384380) stale_head=3D1 =
ref=3D0
>
> A KUnit covering the re-read can follow separately.
>
>  drivers/net/amt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index f2f3139..af6e28d 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -2455,8 +2455,10 @@ static bool amt_update_handler(struct amt_dev *amt=
, struct sk_buff *skb)
>         struct ethhdr *eth;
>         struct iphdr *iph;
>         int len, hdr_size;
> +       __be32 saddr;
>
>         iph =3D ip_hdr(skb);
> +       saddr =3D iph->saddr;
>
>         hdr_size =3D sizeof(*amtmu) + sizeof(struct udphdr);
>         if (!pskb_may_pull(skb, hdr_size))
> @@ -2472,7 +2474,7 @@ static bool amt_update_handler(struct amt_dev *amt,=
 struct sk_buff *skb)
>         skb_reset_network_header(skb);
>
>         list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
> -               if (tunnel->ip4 =3D=3D iph->saddr) {
> +               if (tunnel->ip4 =3D=3D saddr) {
>                         if ((amtmu->nonce =3D=3D tunnel->nonce &&
>                              amtmu->response_mac =3D=3D tunnel->mac)) {
>                                 mod_delayed_work(amt_wq, &tunnel->gc_wq,
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
> --
> 2.53.0
>

