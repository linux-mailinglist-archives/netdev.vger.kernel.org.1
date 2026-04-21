Return-Path: <netdev+bounces-280256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMwaNkT052nrDQIAu9opvQ
	(envelope-from <netdev+bounces-280256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:03:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5275643FF59
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7543A306E64B
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433CB366061;
	Tue, 21 Apr 2026 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="INV99Vzg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86687280CD5
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809015; cv=pass; b=QoH5lWJFj9UpBj9OrLgrCPzPSQSdocgRbtAeN2tYbsXPDv5TZ+zk/mGfXVLMi6jyyRLlDDggS2JggQ76DPbkR/hlPBh2YlC7kHswpEsod0hKNs4DuQERGMUz8yVM2MmdrmRU5u0I3x1CajY38klObRLViGGDzdlpmX14B5mOspI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809015; c=relaxed/simple;
	bh=S1NvDxDjA0nFgq85sq5CrIpAKp7K74I/oJLFFll9NaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBGs5ycvZ6ftdkM3Q14TLbi1fwlOTH2T+UgnmpLIht6GNmIQ2MqR3E4Ew8F4qePO22Sk7xyNYkxvXo3UyyGbdA1LW+vR1cOxnHg/9QJ86lReOrhP2/oHwy3CDGRhIj1nhmxilF75wUJnfKFNqKVA74Qorrb9ANJ/tgjuT5lQ5hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=INV99Vzg; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7b186dfc1d0so69725647b3.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:03:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776809011; cv=none;
        d=google.com; s=arc-20240605;
        b=gQhM0Hjd7G46TehM3++Jj8r78ogYOX4tIfHDD32JbQuyZNL0froJi/zJ1cwQa2CoDI
         HyHAuh/mOWasGBzDbuUxSt6CA45vcc3khj3QtDCkAyEbjwRB//+K8dzMaBL810PjIw1E
         IAItd0GqVgHF0Ldpkh23we8/8IeeAJW2Tc+OpMeapwR7B9ltT3e6GOqYL1KWZcQaQqFi
         UPNAAbog/s/45NYnfLsUG/UnfGQ/bLiwp7uHjvXOpu2BHfnhyJCt4kVWWMgzdKM6P8Yf
         /sdncidaOqyKYk8lFx/mGhMwnoJ45yHcrVQjcQZ9WztqX3PINliP2JBdU4VJedqXdOII
         zHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S1NvDxDjA0nFgq85sq5CrIpAKp7K74I/oJLFFll9NaE=;
        fh=XWCMsXfgXELJz+yXHGYCN2YfpUOM7xYEJ67O2Utb/fU=;
        b=UFso1mMRuxGU4EK5B5153WzwtV+3UOXTcfTeCXQ8chlSmouWjJ9UMehagvauIOmgPe
         YqrL00gqM2xxE+EMK/kVcihobczgLtwNnYG/S2fX1Xdxyijv9ER23FMX2FEVbEyx2CLQ
         /PA+atymP/jEOCwJhbLdE5pM+qwSIBFxWlsVzRDSzX3/Z7MopRd1LzWRmUe4KL4BbCrA
         2S2WdyVm6OGnwcIJA/eAlCmyRoespriWflh33Yi2oMcjcznhBDmA1hHUFrsFSDDmEc7o
         d8UgQmXLjtMX5gb0Dliw1sg7awmfNHInleo/QjV1tHc2zcuFVmv6Yp+dHjJ6035szDF/
         2mWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1776809011; x=1777413811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S1NvDxDjA0nFgq85sq5CrIpAKp7K74I/oJLFFll9NaE=;
        b=INV99VzgByAaUC4GU5Vg3Eje1DmWoocL/5KcNXcuQWZuunrAIaJCdGzRqpNWXJj28l
         tJRkGCvXjycgnEiAr4CZs5SiTA4Pv3nQmgbZP4vqamrvchIp475Ll5VPTFnvHFONZIu4
         yUOFx9WsgJYgn/P5t929dLgHsNasDmXGHQHYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809011; x=1777413811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1NvDxDjA0nFgq85sq5CrIpAKp7K74I/oJLFFll9NaE=;
        b=Mei7gAf/SGtO1WwAK1oDE4vXDq5qiDPnu7U5+KAMBv5iWplh3nMfzr59FnoRsfifM1
         iAtWCM3ZV71U4rrKGSwT+Ika1KTjMm0WnQS/PYhDYXAMZmg9Y9T2NFO32wnlRwp1vCVX
         Vn5eDEAEZxHdylwRWy7Q0PcPQAT9zU6VpgVejGfo9iuXYHMghLBt3ncHgsqB+B3MTUBk
         YqFne7l/usORAIC8HGa8bgFMIbsuSc8PrU1NZJhomzDjqsoYTt91uvS3SZM3wml4qWjy
         o8f9zwqP6yEche+KUTh7A+ukfrTDzIwAvvaktwjUeY6VF5JnWNl/OGYhKJlLoPdm6fLk
         deQw==
X-Forwarded-Encrypted: i=1; AFNElJ9AjGX489BM6fnnw8Yk18bNBlXHj0+m/Vg9yweUTzY2hP/FPjXqaakRhCt8mAQabs0YJ6mwSnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxFaXKl3O+9JAw4IImLKufE6B1qLZkkFmcWSENk4HXOmgXGbPf
	n/QKHwjmAVkDcFEs/p8bPX51ewPtweIzHmsXvniiIZ2Qh1ruaZd1W96E0aF5hfYA/6d4qiiiWHi
	C2pSVFwUaXvMi4XxUm+SAN9hQVfJDqi9vZ+NS0uSLoQ==
X-Gm-Gg: AeBDievXmdlGUR26GptkdGUngte7yXQ+8wt4R0TmrKxya07P8A1jlsR0OUxOEC5UcFN
	Sy8Ao12mfwItKd/wXcseRL96bcX5uMJkzXmY6ASgjHlX3LswSv4t7EH7e0z5/F7Z2jyx0JVWnWJ
	5JA0PvkV4dB9hOMaGr4JGUigxIqaBpBoQUup423qQIeZVP2j2g/1sHcK1oF59TxJ3+/Jy15IGj5
	R1YCyHCXESyQ/oLL2CR8PBoRDE1gw6OSnTgYK1iK1Gl5asiXP8AV+pDfdirUdeqQ85qyG5RXyAe
	JyDajqHg6brbwFQBoLRhstUtWdZmMzzplE0ccF/uAVQy/VG4OBs=
X-Received: by 2002:a05:690c:e3ea:b0:7b3:8a18:ba7a with SMTP id
 00721157ae682-7b9ed41801amr154062417b3.17.1776809011367; Tue, 21 Apr 2026
 15:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
In-Reply-To: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
From: Daniel Palmer <daniel@0x0f.com>
Date: Wed, 22 Apr 2026 07:03:19 +0900
X-Gm-Features: AQROBzDi0D4-VCfdphZ_nYuolvWfMt6mc0SBnOeI3WNiElqSLF1z65Owh0tseBM
Message-ID: <CAFr9PXn1ixyhD42OswoyGZ=W-O-oZygUGpRNm2dcAuYBNgtmQw@mail.gmail.com>
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[0x0f.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[0x0f.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280256-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@0x0f.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[0x0f.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0x0f.com:dkim,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 5275643FF59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,

On Wed, 22 Apr 2026 at 04:32, Andrew Lunn <andrew@lunn.ch> wrote:
>
> These old drivers have not been much of a Maintenance burden until
> recently. Now there are more newbies using AI and fuzzers finding
> issues, resulting in more work for Maintainers. Fixing these old
> drivers make little sense, if it is not clear they have users.
>
> These are all ISA and PCMCIA Ethernet devices, mostly from the last
> century, a couple from 2001 or 2002. It seems unlikely they are still
> used. However, remove them one patch at a time so they can be brought
> back if somebody still has the hardware, runs modern kernels and wants
> to take up the roll of driver Maintainer.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

I replied to the single patches for the ones I think I have off the
top of my head but maybe I have a few other these.
I think on x86 people running machines that have real ISA slots and a
modern kernel are going to be fairly rare but I think there is non-x86
hardware that has some of these and people are still using them.
I think the pcnet one is used in some PC emulators too?

This is just my opinion but I think it'd be good to give people a bit
more time before they get removed. I thought I was the only person
using the 68000 (a cpu from 1979) code in the m68k tree for years
until out of the blue a month or so ago someone popped up and asked if
I could fix a bug in it since I'd fixed a different bug in it
recently.

Maybe we could add a special thing in the maintainers for "this is
code only crazy people use" and have a rule to ignore untested AI
generated patches for it? :)

Thanks,

Daniel

