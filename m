Return-Path: <netdev+bounces-247828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 825E3CFFB59
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 20:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B065D300B020
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 19:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B50350A25;
	Wed,  7 Jan 2026 16:58:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E793451C6
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805128; cv=none; b=Dy/r1TFaQvxpwidde4nDS0AYxWZ1pHg8Q69Hi6mmNW+3sm2QrnKvs7EYOvx7R1eMfSEBgKxo90RH+cLsII9lG+8QOR4Y/lfGdEEzdW8Ri1HU8PvoEXa7nTnqQZNjIsHUp6ScgJTxgSc6ycZbJio7kQHA1E0yPJNTg7Jz+4yqHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805128; c=relaxed/simple;
	bh=m5WDIZIi3d768WXw2bEW3UP2IIBOeDrI8x3vS1dMkQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaGxMAhaNiSo5ZB3IWo6bK5fL9qIZ1xGgEer5w/52fdQVaO4MA3msPK9oAQxo7a8/dm5Q3GncMOqU/DYV7a39SaxZmEn8cgWGxc2P+nqwGxWUqTiXz5LRumeq/RLhDm6kqxyM0wN81llghwrE5HIJcJrzINmXqalXlz804mDPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c7503c73b4so1205286a34.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 08:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767805122; x=1768409922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ICq+3QhS1/QYa5EnJldE7FUJw5ckZTY5TKUvUBnPks=;
        b=sZ6YDYc1fxXQu3qGR/OVphiaF/HBpYcTeRBoG0DW89PddQawfQodZS4m91H0wSsgWv
         JzdpEZp3Lq7YTCGFE0NWCNIhvmttgexR+tDsG3WOUFFKL73PNsnXZXFd7V0E0KGjGXGM
         JwsLZYljb6tIaM6BHVlVsj7jJpIEiD/6pe3FERK2X5oSpCLAcHakYWzAOQ4r8jlaJnBa
         H5cN7vifDZSs/h3dj+KAv1E2UGYgQlZtLOATh25HXLeai3WZa3t7Dudj+koYLlHxmz1z
         bfJqli6T6VrpElAkwuDiRjHkfo5+en/w9el2E0HI1G5G7vlYcHpwr+5iNB52HALvE4GN
         ziAw==
X-Forwarded-Encrypted: i=1; AJvYcCVzfZeOtFMpbhJIuo5ctnsUJUwZ1JT3KUBhDIQkRsVGw2+J/zkBj1wM0Shhs5RvEfSN/nvOnD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGijV45rud4vtUigNA/PIAMfMZ8UvkhOhssozdWVnxZBKT5tSz
	P4LliH07el0IyuveTVXAstH+iJHDKoWtFJCxNplpkLAzDyhdBjNIr6ec
X-Gm-Gg: AY/fxX584AF1bTrvH/qn3syR6SB70Zt1aL9nKhbkFo/tfUEBb+4o3EHHKJwnCXDkbxo
	IRoDs19UKzw83EKUYK4Vjs4jjkje5jNjFLMsASG/gWF5lZBrBO9iRcCNnUAQzqXBc6p6kvdJYQ6
	XHg1/UZk7hvVVKTfnz0xeVk1qx4z+8XjkGdr/+l1UzaYMCvgv/6OMaKoiOyZ2fobgbdR++SD8bK
	SZbpP5apMrK3T+utppFDW4sA0fdESOyKMNYPF0uoreGesThpDiwk+8HPK1MmkfoOw1yYI57sbGz
	2NLcuFrIa13K43QVXsGZqRxYqT/ZAktWxBWq+aQ6KvDcB/CeAf9+xS5IPO/9DdUluLGbbvx+ufs
	Hb9MktTiWIJfxvmE3OVeeVG9FnDntGKvPrxmPb4vwClnz4EeMv8COsdC5tnWubqVJ9zBOA4jB3j
	9C32A/FcGyP5HZhQ==
X-Google-Smtp-Source: AGHT+IFc13I3F2mIIe4Fwfz9kARgujMXq0dFx1fcCN8Gp8WazR5CBs3+RoMWkUBSEgtOxvi0tOnklw==
X-Received: by 2002:a05:6830:25d0:b0:7c6:a62d:8663 with SMTP id 46e09a7af769-7ce508db6b5mr1908773a34.11.1767805122167;
        Wed, 07 Jan 2026 08:58:42 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af813sm3717716a34.19.2026.01.07.08.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:58:41 -0800 (PST)
Date: Wed, 7 Jan 2026 08:58:39 -0800
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: pmladek@suse.com, mpdesouza@suse.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com, 
	calvin@wbinvd.org, jv@jvosburgh.net, kernel-team@meta.com, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
Message-ID: <4dwhhlnuv2n3f7d3hqoulcnsg6ljucd6v47kqcszcwcshfoqno@rzxvg456q4fi>
References: <20251222-nbcon-v1-0-65b43c098708@debian.org>
 <5mpei32y7sl5jmi2ciim4crxbc55zztiucxxsdd633mvzxlk7n@fowtsefym5y6>
 <87zf6pfmlq.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zf6pfmlq.fsf@jogness.linutronix.de>

Hi John,

On Wed, Jan 07, 2026 at 04:56:41PM +0106, John Ogness wrote:
> On 2026-01-07, Breno Leitao <leitao@debian.org> wrote:
> > Upon reviewing the printk subsystem, I noticed that struct
> > printk_info->caller_id stores similar information, but not exactly the
> > same. It contains either the CPU *or* the task, not both, and this data
> > isn't easily accessible from within the ->write_thread() context. 
> >
> > One possible solution that comes to my mind is to pass both the CPU ID
> > and the task_struct/vpid to struct printk_info, and then integrate this
> > into struct nbcon_write_context *wctxt somehow.
> >
> > This way, netconsole could reliably query the original CPU and task that
> > generated the message, regardless of where the netconsole code is
> > executed.
> 
> But by the time the printer is active, that task may no longer exist,
> may have migrated to a different CPU and/or may be sleeping.
> 
> IIUC, basically you want to attach console-specific additional
> information to ringbuffer records, but only that specific console should
> see/use the additional information. In this case it could be up to 4+16
> additional bytes (depending on @sysdata_fields).
> 
> A while ago we had a discussion[0] about adding custom

Thanks for sharing that discussion link—very helpful context!

> information. There I even went so far as to suggest supporting things
> like a new boot argument:
> 
>     printk.format=ts,cpu,comm,pid,in_atomic
>
> (which could also be console-specific)

This is essentially what we ended up implementing in netconsole.

Netconsole makes this straightforward and efficient since I don't need to worry
about ring buffer space. The approach is simple: receive the char *msg, copy it
to a bounce buffer, append raw_smp_processor_id(), current->comm, etc., send
the packet, and free the buffer. No impact on the ring buffer or other side
effects.

> The result of the discussion was killing off dictionaries (that allowed
> variable length custom data) and replacing them with the dev_printk_info
> struct.
> 
> I am just pointing out that this kind of discussion has existed in the
> past and not suggesting that we should reintroduce dictionaries.
> 
> A simple fix could be to add an extra 36-byte struct to both
> dev_printk_info and nbcon_write_context that exists conditionally on
> CONFIG_NETCONSOLE_DYNAMIC.

I believe we can achieve this with less than 36 bytes per entry. Taking
inspiration from printk_caller_id(), we could store both the PID and
smp_processor_id() more compactly, 8 bytes total ?!

Something like the following should address netconsole's needs:

	diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
	index eb2094e43050..908cb891af0d 100644
	--- a/include/linux/dev_printk.h
	+++ b/include/linux/dev_printk.h
	@@ -27,6 +27,10 @@ struct device;
	struct dev_printk_info {
		char subsystem[PRINTK_INFO_SUBSYSTEM_LEN];
		char device[PRINTK_INFO_DEVICE_LEN];
	+#ifdef CONFIG_DEV_PRINTK_ENRICHED_CTX 		/* Something that I can select when CONFIG_NETCONSOLE_DYNAMIC is selected */
	+       pid_t pid;
	+       int cpu;
	+#endif
	};

> vprintk_store() would set the extra data to dev_printk_info.
> 
> nbcon_emit_next_record() would copy the data to nbcon_write_context.

Thanks. Let me prototype this and see how it turns out.
--breno

