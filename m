Return-Path: <netdev+bounces-300536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UIouI7VaNGr/VgYAu9opvQ
	(envelope-from <netdev+bounces-300536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 22:53:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C5A6A2ADB
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 22:53:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ARllXj4Y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300536-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300536-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 350343020D77
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 20:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F4D3370EC;
	Thu, 18 Jun 2026 20:53:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1D8316905
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 20:53:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815986; cv=pass; b=UtuxWuFvfSJXPmK1e6RjlpY8bwLbp+BiVoZFWdceDur5Bz+kQfmby3LOizc3PeTguInLkZr0R9QzQxtg0Lh4wKFKLrWb024mv/JVcKpEOf8HqDzaUCrJOB2UeRxyBKJMR5LlBtH+dmisnOSi7HoxU50eA85+W69cw4Xmx0jqdrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815986; c=relaxed/simple;
	bh=ehviqEd5qqn7gx6uRwzm4aB4cg9Ls5vhvcmdcrIbKNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8UH83BHN0J4CujAFsFcr0eLKdsKwCnRJ4FQb/vO9pcSKVdvTWNH1EZd+/zIrx1ThRb1SvDsWB/tAP5QPdVY6i1TyWzGmJ3195/G2mMehphboKfFCnyoZrRUUfQFjc8X9TIFD7Wmna8tKMNJdrX5OB0vlGrzUeMb6h1mK3C94e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARllXj4Y; arc=pass smtp.client-ip=209.85.167.178
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-486badc02ecso623996b6e.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 13:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781815984; cv=none;
        d=google.com; s=arc-20240605;
        b=BzxrR4zleR8hm8DVN3tgJ1uT2ZWEhHN59tW/QuVVloW2jdrxyHwDjhVMk11qHII/Tg
         pc8A3hAOYAiq1nb4sAchDF6FatAf1Rp4bLkRCOxofMajCT0rJjrVLY67IY74qCbq6bKD
         vtPwADWqjgq3Cg8lV/tuMBNAdq/ENIq2dyO57DQbnYanr3aY2KDPDwNygWF8B3SHq39g
         VpYvd2yzdsZ8AyniBPqXH56gkgHjv/+7GW+pzp7/VAgSloKV77Viz29dfCRZnBvPxMQ5
         +k2io8ElWpC70QMjP8518LY9mVrYIsAx3qAOAkZVc1Rfj5oF5JgL92qiSQYvrh0JdAHv
         Tqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ehviqEd5qqn7gx6uRwzm4aB4cg9Ls5vhvcmdcrIbKNY=;
        fh=FljI4nV5BH5ikIcmVyNB405dnabXZ0u0ml/gwzGcj0Y=;
        b=OTo6SKX81WG7UiphJ0JIxb4RLbSIEIaH2IvBw7D/SrRHU8Ix9vhgwZ/nURPCNpw3S7
         xI3e52KZTkl5fKVutcCtF4SQZgFePjSYJhmM5MLaFlfPAcr6humUS52vyWFxm4LJc3Fz
         klkAdL0sm2R0nI564BTu6rMR4pdgHGvFg//3g/pUeWQNDKAJRyVq1UVT0wr6JvLylVz6
         mldkGH6aXzqJLy3kwlLHejLnzTHKwFIfUUgusyC3w4J8RzZSJlHPN2jz8w7Z2417k3YT
         irvT9tk2p2d/aQzoc9JrulHTltR17VmODjbd1eNHF1jz7iP99/r9fzFBVpHKNRw6cuJ+
         Xsaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781815984; x=1782420784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehviqEd5qqn7gx6uRwzm4aB4cg9Ls5vhvcmdcrIbKNY=;
        b=ARllXj4YKTdxl/HYdr99PnHQHdtk9VZwYnHd0qq9Y8snnZUM5Dx5wUb2UHpNP5P8AE
         oH9J2OIqLaRzJcVVS3w2RhMLkiPiLTRWLGdE7ZPj+dYQXPHxY1tt9zQDi1lWBOINimsu
         z2qHR8vyb9SYmsxt2LcL+aVLLTm0T6xx/6v16uYq0ywaZQk0MAQ4YPIy5rCWjLki5Wj7
         qDaW/jQqF+13MhqY+QyM5ZLIQys52Fqad0j3XvTUGClUZVOVjhQ2jnLBhUnZ09TpIzwm
         R0jsEV7+7LXn1FxANcRT4iUqClzzKtVV8RGRD6OhOcTyxmlxQZDZHHUuxaP3k3mJ9/r0
         6qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781815984; x=1782420784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ehviqEd5qqn7gx6uRwzm4aB4cg9Ls5vhvcmdcrIbKNY=;
        b=NppnudlO/HHT1z+LrGrG1AC0a9b+rPraBOQD4/slP+76n5g2wVbB7BMiAO5fRHBHJt
         a3YPdPGi4yA4Ohz1s4AxZ9DeUSHVBjLaUo9Hud4j6N1zexe+gJ23MTxjzCQTU1HNs+W1
         heY3dHc7sR8Zg//TdibCIv65jWjhriRY0zZEvrEgdmDp+s9lEdbV+zoUTycIIqC619v9
         K97XcHPKO+x7PFf9owZ1Lxcw0u1mbUDOPF2S45mHnUC9VATJQ0sHQ+aHGVyhSI98N8Uw
         AV4PvNQ13iUetd7yxJVwJU781lwpqWpZ7QoiK28e3FSXU62LG7V38c/RHjM1vrkSQ1Gy
         uiDQ==
X-Gm-Message-State: AOJu0YxJH3qgpBy/hN3QRry6PN/sjCgULILNnHYJx3Rh6VgC3GSLifY1
	LlwuVshPHubDQ+JmvEtbCqR0dU7DJ93c0moPqozswUyjRUm93fPeMjhrC2lwahOGhutiZ/HEAJC
	+2hnljsYFThzUEsSI0cJaORAogZvUwfa9JcytW1U=
X-Gm-Gg: AfdE7cmO7KGH1cT54HEV4SLMFiBVgK8H0PuAUbcprDVzAhLYtIKws4UOt+Ky3hXw+q7
	ODebNzUJDjcDsIxkY9ihwlc2+1TIZstoF2U2NoFBhQSHZs7YJIniuTaF05lKSNKBNfOJntN3n+V
	zvWODk3LYGn6UYjMSYsbGqVJ8+SouC6KMGfrjntnUvFbSD9ETza1ZqcT3sTQkN5ZAWMP7mX99Ts
	12wTojKh1Sw6wIEhvSXt/+MehTBmDwgeO0bSDsAYZFbIgXhjugW6Ahs9w/oLW/z+XL23qWdInGW
	bys6txwox9ueyXufdoB/cEes3TK1
X-Received: by 2002:a05:6808:6f89:b0:482:ab19:b1a3 with SMTP id
 5614622812f47-4896aa3d615mr899618b6e.14.1781815984518; Thu, 18 Jun 2026
 13:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618140200.1888707-1-mmyangfl@gmail.com> <CAJq09z7fBSdknaNW0ufBYm4wO2vL1tuBjBW5FV3NeGRg8749SA@mail.gmail.com>
In-Reply-To: <CAJq09z7fBSdknaNW0ufBYm4wO2vL1tuBjBW5FV3NeGRg8749SA@mail.gmail.com>
From: David Yang <mmyangfl@gmail.com>
Date: Fri, 19 Jun 2026 04:52:27 +0800
X-Gm-Features: AVVi8CcWENv58gQy4kvw8LLB685ojSLTpKJ90ujSrOrhN17smb9Ag6SzWNzvZIc
Message-ID: <CAAXyoMOHJOPHxDE4s++ddhgeVJC3SeDthWhMUHSGEHva-JZTZw@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: realtek: fix memory leak in rtl8366rb_setup_led()
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300536-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:luizluca@gmail.com,m:netdev@vger.kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7C5A6A2ADB

On Fri, Jun 19, 2026 at 4:12=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:
> Indeed, it will leak. init_data is local and init_data.devicename is
> read by led_compose_name, not stored. However, stack is a limited
> space for allocation.

I've checked the buffer is long enough to hold the name string while
relatively small (only 64B), so it should be safe for the stack.

> You can alternatively solve the leak using devm_kasprintf() (my
> choice) or adding a kfree() before leaving the function.

devm_kasprintf() still makes the memory unused (later in the driver)
and unusable (since normally you won't unload the switch driver until
shutdown), IMO.

