Return-Path: <netdev+bounces-266647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKg5D4RtsWlVvAIAu9opvQ
	(envelope-from <netdev+bounces-266647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:26:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 441C42647B5
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40B8E303ABDC
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80D93164DF;
	Wed, 11 Mar 2026 13:24:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D08B2DCF6C
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235457; cv=none; b=NK99wCHMh1FDF72D8QFl19HX5wKmg/O4SLETxZI+jK/dT1II8VVS3Ybcpd/Gbf/iP1Li94jKNdIt+b49F/pwc9QzodQ0PGIoZVauIJ1MbB4M6niC5YXelkXcWztWUYJmexBS/dy1EULoxz9C5nAzQQePUId5XORIvsyvFnO73tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235457; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQPNpLDxDuwLtAdrDHmsl0Fbe/Ba2ZToOfhGIUO6jnm5EB6n/rbVnggpeE8ljBtRuC7gBE8rDZPo01bLoUjEivNzO1YK6v/g7tr0fNv2TPRmi4vwBm3VFHZ+TToBxfdsJzKbNJapJBOhCt5jRKD5X53qQ2aaeD8GcNuJcEZ4jU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5675d609621so11792975e0c.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 06:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235455; x=1773840255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=M4/IBJc1tCrsuNDefpT0UxEWakWscfR71Dp9eR8nnjTmkRVZP2pmp3DYOr9+BQiRR+
         xsvoiihQ8DEtF0aAMf1Gc41vJHRCovx7K/LuqqX45PeNQqlFG5D5GOExbJXkFliY71SP
         fqYekVfyJjde37EB50EqK1rM1tEBTD+6wakxvqwZsi2VtXY9IpTT/16IbslP6DTOgKie
         QFa2EEMlaQWxc73WhlulpvZASkbfI2EXSsbc6S5OZ7Hi4/f/LJNo8RgvaHC+o/kpsYDf
         VoX+J9Vw/D2KB30G87YdQINtLUjbjLx6k1gvtzySHyiW6wwtqnhaVtBJU/mNuhIhQZLG
         pcCA==
X-Forwarded-Encrypted: i=1; AJvYcCXoFCQkR+PpXzx54VaQusAnogVnlq0e/d6EFZWu/X+xQk7bcV6km1tnH3vsLA1o0AfjVxGXHyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWjFxRoE3yNBT1rc/5cVlVfRK9XaTmc0HHEhMrufnlfwsbVmim
	2RU82sGInoW7YOwaXB1Acir3n2ggqowM9Pyol4hHYYVRdQlF9Gx5zYzY+kqf5Vr4ifI=
X-Gm-Gg: ATEYQzyYA0wYXfmHb/K62nhkkymtJ4XiEKpGp32CljbDC6MrbRgkiuI0ZSiDud5EiYo
	/IrfJpAvUHfu2zpcayyiV8Jf5jAe4H56mY8psNf7yxuxVxsiNhmwZ9JtsiGlMx3CQy+eDGwrNuu
	eM6Z4DZfhx0r5nN9YeeR0exa9IxRkZYcmy6HYKvxGyLdrA0+QfqUz7xm9vkh3FJYKWRWDzj5G/D
	1ImmZ/NfEmBYiq6gjq8IMz8rVfmUR5wWn1EVNHLTwKbhhSaoAy2aXTIhuYAWmBlIO7KCRHMGk9P
	ngSBponzuHtJ7xpFYjOz+ajF+odOj0mfYlvRH7RgRJ4285xrTUnfa78VMu38n2HT3v1hQgAL6mn
	VIZiCyuFm0pTQy3WWMr7iCzWRgXRfevB1lLSePG/bs1WZF/D9Wp65wwPyQkfKZ57HJpkM2E/sPF
	iUErWiVQ7m6XS6Rj1/0gurYlCRryq/PMAzDChbeX5R+yD9kJAKaSTkO/Tfi854
X-Received: by 2002:a05:6122:8c17:b0:567:5ccc:1367 with SMTP id 71dfb90a1353d-56b4752d741mr867196e0c.11.1773235455407;
        Wed, 11 Mar 2026 06:24:15 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94ecfc4dd70sm522779241.2.2026.03.11.06.24.14
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:24:14 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5ffc879c1aeso4445988137.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 06:24:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBIpagyh48dmCGgf7eaaQXsJnaEDc2ioWwvLdHXL4mMN84hFO/nW2SZbpb7ZSHjXUYRMrGJ48=@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 441C42647B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266647-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_GT_50(0.00)[57];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fu-berlin.de:email,linux-m68k.org:email,glider.be:email,sourceforge.jp:email,libc.org:email,avm.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

