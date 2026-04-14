Return-Path: <netdev+bounces-278350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL9tB0wC3mkRmAkAu9opvQ
	(envelope-from <netdev+bounces-278350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:01:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C30B23F79C6
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83F88301A7DA
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CDA3B9D96;
	Tue, 14 Apr 2026 09:00:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95363168EE
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157237; cv=none; b=JqxRqcg3rZfR8ZrJRi8CX/d1dQOILsiYhohaYm00WaZPkXwXxdBXfyXSN84vqHYMgDnxVvqaWwTPntdQNsNRkeJohTFJ/YtiahVk/SjRQEI5eg1H+YtO7XviycofvlwZoc4JePSUHINZWv5NAnhZjmlDOx7OlekkswF/LCS1Ayk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157237; c=relaxed/simple;
	bh=7BzH4l41ivGVwJZyLUtzjEKcBbitAg70COzuLd4I7K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WM7n5vXwxrFbmoOWt9WO2AJFZC+T3acKfwAkTolm4wbuyc+fT/LMRVApi3KgrWBqzLz52jT6BG+ze3czGKI3USuqGEyHikNNJBHVvEONoK5HUcj6kW4FGsz6LyvmIhO6CYimmSc3Bw+WEkPAsT+aKHtZiDS4HHHW2giTvJ9uGzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-68a3b605bdcso2693329eaf.2
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157234; x=1776762034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7BzH4l41ivGVwJZyLUtzjEKcBbitAg70COzuLd4I7K4=;
        b=SK+B1kiETvDiAHirZxbekMpVpCLQoGDDdDxg8ZX58nQsf+RBVyFtsehWA2LOtuDwh0
         gIM8NW1gj7rcwv/CCSTTxEoYC8Kf/i0uiceoV5ff+6+1DEyPSghEBZt/DbPO4w2iuQdR
         oqsyMgRmjOs4gOl4rE6WvY7muNx4TyK9OrclLbzppn+8Fdo1BEXpygipww6F+KfCJf4n
         llsMElt4/2e0xfwUITIDDTAOOB0DmZbQ78/vxJADHcJQIdhszOsozOkjE3tfrr+xpfSH
         GTC8CTa68gLVBdG/i1sKT3ndB1h79lim/5EFb+zCp0MOX7tnnNew5moyMNRrhJSLfsF8
         zdzA==
X-Forwarded-Encrypted: i=1; AFNElJ/z6EOfbhd8DbdoCqAbllFmMgKb0EpzN/TNcd3ASP1mD9+Qb4b1vJWnemlIEyaJTtFl0CCH5Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU7ghbhxgjpZqRSJlyX5cPqrwCKXyhKUd9Ki2+3GoSqDzm5Htf
	x1qQgCnmEY7pB2uNz339PiF4UfDLJx5WjtowR8HU9NTyCD6iOHNxYh2C/4xpISdy
X-Gm-Gg: AeBDietTF+KJa5xCjhHfzinU7uKtldGDcpVD4t7b8N3Z1r/0mX53WxSyFUJzD3SheTa
	i8dawpOcHnrb7gCouq+dopeLUotI27bEWBopSgZH8sO8hz57CYXJiEIQzGAHeQoFG2+43qPfbtN
	ynzq+c7GOrNpbe0qTO5ylJUeq1gJY3P6WWBI94PSGFORcGEH6lpN0F/y55eeS8Ofm4hTkar4QAC
	o/PZO9hTWu1aady9xrHl6Hg0fCuQvvDn4dQW7q9VyLITfM6A8Sv9+5NzcRPJkqwoYN03WKfsISy
	Fy3S4jUrhYPBjG17tI3gwiFiv+/RUHe0uZT4GquF8x7YFqRbZFQo1LvY72MSYUQqqf+6FkbSqo7
	ZRdFrTKG4QKCtebffTd9b7mSqoilHRuVVi30qOPRA8jZY5xIYvMnj252S6xzjaE9ip3JliIYPIj
	4VwQKUxjgXIxruZ8hrVZ/mGCy1yAsbqEcQrzU+IiB2EoOyA6D2ftMJucRnab9t8vzAkW1iGE6eG
	Bkh77vBcgU1YPaLK30ATQ2JyREeEHOPreXs6sejW1SRfN4/JouyND242Ascbe4BnS+xS0Ke2w==
X-Received: by 2002:a05:6820:81c1:b0:691:e8ce:35c2 with SMTP id 006d021491bc7-691e8ce3611mr562458eaf.20.1776157234320;
        Tue, 14 Apr 2026 02:00:34 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bc88c7493sm7199042eaf.7.2026.04.14.02.00.32
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:00:33 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d556c1a79eso7287428a34.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:00:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+VrPZsaMsrksIH/dOfPgR/swIGaavu/+4eoeiyhga3GXpU9RiIlNKicnRanauHIV1D8pO1bzA=@vger.kernel.org
X-Received: by 2002:a05:6830:6d44:b0:7db:df4e:f937 with SMTP id
 46e09a7af769-7dc27ca49a6mr10107828a34.7.1776157232558; Tue, 14 Apr 2026
 02:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com>
In-Reply-To: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 14 Apr 2026 04:59:54 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-dvJA4yLJxwiJVg2S585Dihg4c7FTyf0Gv8iwahU0ifg@mail.gmail.com>
X-Gm-Features: AQROBzBGriz3oUw4obwCyMl6uueqnkEVGw3CzezDOXXcUajBdgbMcTOpUgPlHRE
Message-ID: <CAEg-Je-dvJA4yLJxwiJVg2S585Dihg4c7FTyf0Gv8iwahU0ifg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add Broadcom channel priority commands
To: fnkl.kernel@gmail.com
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-278350-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[gompa.dev];
	FREEMAIL_TO(0.00)[gmail.com];
	RSPAMD_URIBL_FAIL(0.00)[gompa.dev:query timed out];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,jannau.net,holtmann.org,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neal@gompa.dev,netdev@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[devnull.kernel.org:query timed out];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gompa.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C30B23F79C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 1:46=E2=80=AFPM Sasha Finkelstein via B4 Relay
<devnull+fnkl.kernel.gmail.com@kernel.org> wrote:
>
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
>
> Certain Broadcom bluetooth chips (bcm4377/bcm4378/bcm438) need ACL
> streams carrying audio to be set as "high priority" using a vendor
> specific command to prevent 10-ish second-long dropouts whenever
> something does a device scan. This patch sends the command when the
> socket priority is set to TC_PRIO_INTERACTIVE, as BlueZ does for audio.
>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
> Changes in v2:
> - new ioctl got nack-ed, so let's use sk_priority as the trigger
> - Link to v1: https://lore.kernel.org/r/20260407-brcm-prio-v1-1-f38b17376=
640@gmail.com
> ---

Thank you so much for this!

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

