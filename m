Return-Path: <netdev+bounces-263026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GcbCa1TpmkbOAAAu9opvQ
	(envelope-from <netdev+bounces-263026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:21:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2650E1E8756
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A66F301A68A
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6D237DE86;
	Tue,  3 Mar 2026 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF+DXX/N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFC4377027
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 03:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507959; cv=pass; b=Or0dUcJFRO5AasJ3KPJEQhSjTM+tioE1RCA01fycW8Tfm1FvTM9tCXPqwpLiSgsDfs75V7PjJGJ6afm1JGwc0afNUwY3odymVyX3hh00ZtuPxRxSaXhfLCbhNSFVyw28kdVg8SI3uFEyBI1qE0NpAfiNLO0CBDPlawLmLkJYl8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507959; c=relaxed/simple;
	bh=3cUm8axmkw+3/dDmdPZqpi/e0NpUyKR92Jh/XMedh1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZPNMA1cWBCVhMMfdihfGzA66ETS0AXreLRuWmi2G9aIF+ISAJOw688AExl2l1umUPn9jiKvuK2Fkr62scmf3WC+ZX3AxtAH45S/mszZ9dXR7i+eQYl2mJSliQX+TTEnEjshCvDNOZHlL5ZH+TVN4XsP+F8H2ComE1FcfZmN5Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF+DXX/N; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-389f9e70ae6so86922841fa.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 19:19:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772507956; cv=none;
        d=google.com; s=arc-20240605;
        b=NxtYNj5QShzSmPY0L9jTsCVO5jD64rMbmebfR33LVZeh9CnRI6CdmFfHscwDylzti2
         1xP+RRpTRN9HkO7lYHDd4Ft2k1Dh/WSzEugWjn4njAqdZo0c7eHnpp5bfCKSMg9H2Mg2
         Z4go6ltN59E3jwIphwAp0xzo8LyEN2pKJ2thl8QL5k59hyk4chI+phyz8YKSM1KnV8HG
         1xavLJO+EBWo106cO/CfVNni9NupbUBiiqpzmIiUpdpHhETtEnAD+8hQ+nuoKZYZB8Ek
         zRcZYNAy7hUgAnp2R39Uueew/7R0P+H93bsNXhLYiYurSUi4vy2taegRWu5S7FCz2afd
         cyeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LWY/rygWYp0YuKAEtprwbxmG+LBXg7LrhOdT5Bv0nU8=;
        fh=jxE9WAI2bMXEGJcakPJzdhpiqYcrGi07VFakv3Uka0U=;
        b=gKKo5cz9rFVUKEowNfnTYp23UdddxZp0poA8pCp1xGm47J6z9dyie54DP2VbYjeaFj
         7MrG69wuWkDsRxCTPPKlimTDE2bdnxBHL4cSEpha2khTpHOiYCqfscDVeMrQiZwule2r
         RuL7Drv/ifdgM/Yw+rp+Rl++LqKJt8npUhvGUb7JoAc7AkR0iVdh2YProIKL46Gn07wc
         huL51XFHfngEcjsl1xRWbHxfJc+2NwzWe2bHgLVAcUz0VbwYUXTiZm98YpskSYKa0Ynl
         WSE331rYatu2DmCLkRi5kMqnlPpC8groZ7vzydliPPEp8jGHhdG/azK9ddy1IaQEobRw
         kosw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772507956; x=1773112756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWY/rygWYp0YuKAEtprwbxmG+LBXg7LrhOdT5Bv0nU8=;
        b=LF+DXX/Nd/xZkMcIhZjy3v4juoc3HM5IsOfxljCvuXJR99hXBH1L3Jsmnt6+FH7fmC
         EpIeTC76kem2pfxRN4QWnM5yKCaFStgiO+ideqKcq+h0Rx6U/iydYwmaIvSQkXBO7Mrw
         Zb4U6tT3ApN1mS+QchwSXsnJcJdSLtjflMHyDAvE5kvj4Cs2PiZZnOabsPBPsbf6M8yz
         im2fft5xTbe6vffaJPrEOxjWC2FsMlkrhVjsvElK0VYYm+lTNIiuM2GIF96KijXcNIxg
         jDDJXFSqYhjfOPv0DffVoDMMjqQudW79Ja+KNefJtA9fBX1ZgRVY58PZAcb5QQkTMCAp
         NKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772507956; x=1773112756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LWY/rygWYp0YuKAEtprwbxmG+LBXg7LrhOdT5Bv0nU8=;
        b=Kh05P0e639XfV16BsBHOL0gvjpra2sbDMjNC7YARqfn35qEfSv3MO7LS6p9xFgRlsx
         Q/seh45Akpel7zrWjBFykt+QrevJKpx0RvRZW9jX5Z2REDrz+UBnZEqtP3kB6VxtKBQ5
         HcLolPFp4bNGw5aB0tUC2V0LVIZlX2c9d2STN1uMcRgPZS6KUQgN9OotRwMAqId9xO/8
         rHwJJ9DyMTFJCAiQNnIkZF01eNEVYJCLNVPK/uR1XhO6SMcbStso0+KcBM34Pli7Wh3e
         kjXqzwfj+M4Ku7lqy35PyzdU4gnybC/Ei9bBoetU9gF3l5uuwLnwWNF+Fpm4F7JCdprK
         fPug==
X-Forwarded-Encrypted: i=1; AJvYcCVzBfKPFapwnPZ35Ccr387Q7fikvMIv8xXuyJQTOfGcB+DZHOQMZDYTAq7oOMjtkyU9MDr9qIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTgf+sTQE8HZ0z3XbdXY9aJ6YifswrKIYVHoJuHuHMc1Nfdth5
	h+szCe0opImehKnQg1xWhaYO+g425yhcHJmkHvvjxlEMSwUAsOzMFnTnziHVjnfce/XBC0GGBzJ
	oioreBRGfT+d+VrZ+nk2gI+Lk5LREnUM=
X-Gm-Gg: ATEYQzw3ORIh/aB53NDG2MNO6FLpWezrO0fc0tnq0n69hw1Op0QpwsDUI/cnaZ9z/AZ
	k4UpO6pissvF/mYBPj7oztBTZOyUxFR7XB5cRWD/x2uMOZeMlEGpgOK7M3M2s+EDB9zmu2adcNd
	OCrC02IMI76uYe0m+epHtMGBicGlb2HUzf0yPcAElBbxSa1INSrnmU/03vkT6gFze5mCY+5/mJf
	p6h5Te2GV+ypN4qP30xe7N+17NsouNyvqjusq5V4/9qTFfIWsSeQipWWOa7hrx37quUjgyGZkLI
	sdR7B93N
X-Received: by 2002:a05:651c:35cc:b0:387:1ca3:57d3 with SMTP id
 38308e7fff4ca-389ff112399mr98724721fa.8.1772507955828; Mon, 02 Mar 2026
 19:19:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303024202.2526604-1-joe@dama.to>
In-Reply-To: <20260303024202.2526604-1-joe@dama.to>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 3 Mar 2026 11:18:37 +0800
X-Gm-Features: AaiRm50gWp5vTSmJWWDXt_FuxjJ1l5L16U1N3npkQtIiRooqXnYz3K12dZLB074
Message-ID: <CAL+tcoAE0CmQ8E61LxeA2yzZohmeDF8f_zb0VrXKOD+YMxCnQw@mail.gmail.com>
Subject: Re: [PATCH] mailmap: Add entry for Joe Damato
To: Joe Damato <joe@dama.to>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2650E1E8756
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263026-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 10:42=E2=80=AFAM Joe Damato <joe@dama.to> wrote:
>
> My Fastly email address is no longer used. Add a mailmap entry to
> reflect that.
>
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index e1cf6bb85d33..a02e9aa9aed4 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -396,6 +396,7 @@ Jiri Slaby <jirislaby@kernel.org> <xslaby@fi.muni.cz>
>  Jisheng Zhang <jszhang@kernel.org> <jszhang@marvell.com>
>  Jisheng Zhang <jszhang@kernel.org> <Jisheng.Zhang@synaptics.com>
>  Jishnu Prakash <quic_jprakash@quicinc.com> <jprakash@codeaurora.org>
> +Joe Damato <joe@dama.to> <jdamato@fastly.com>
>  Joel Granados <joel.granados@kernel.org> <j.granados@samsung.com>
>  Johan Hovold <johan@kernel.org> <jhovold@gmail.com>
>  Johan Hovold <johan@kernel.org> <johan@hovoldconsulting.com>
> --
> 2.47.3
>
>

Oh well, this reminds me of using my personal gmail as well because my
company email sometimes somehow goes insane :(

Thanks,
Jason

