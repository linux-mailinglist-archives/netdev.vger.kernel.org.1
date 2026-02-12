Return-Path: <netdev+bounces-258468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM8iJOLyjWlw8wAAu9opvQ
	(envelope-from <netdev+bounces-258468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 16:33:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E649E12EFE5
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 16:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C488E31DF78E
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 15:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6872B26B76A;
	Thu, 12 Feb 2026 15:28:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77D227BF6C
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770910120; cv=none; b=uL+DNbsXzFqTzFWp28jda6uAiYO9gbh0b0/sFMNkkfKPvr1e3LN0vSZNZVnguf5tVOZlZebpOnO1uX/lAG56k6Tc6XYlWvcQ3EIQjShmoR3TBnW64r359L8WBJbYJSMs68Ut0auhYF4WIESz5Y/cR5eb6VP8j4jhzCOxPW6ycB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770910120; c=relaxed/simple;
	bh=pxs8YbD1TjSNqeCrVp0K89guriRQWw3wRcf8TsFR4x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMx28U6qm8YxjSjGsbLYowaLqClvxEB4KEYUmKllBe+y3OvMDKhT/11DBwhH5GQP3rnJgC+eB8KJaMXaQnobairj6w39kxPwI78Qtk0+XMK6U+Md/HyuXDwlP/Z6N9lBAVCTcLO7nfqQyfGwfmgjnhD/0DgxQyTYGy5uqCdOo40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5670ea44187so2265e0c.0
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 07:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770910118; x=1771514918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1swUXVQRVAJERNN5QK89cxeKMa011a7QNqexhVz+39E=;
        b=gPdQfVO9rvG22Q8lKBwRmmlaYIT6EpLElOeJcBwcddIHz9sSbvNTc8u583+oaTsy2Z
         ZZmifTtl0R8V3jayZcJ7qrI77GqgJAgXMxCKVG4XhiOWyBaawxwp4/b3p9Oxp9dYO+Nk
         PCQnScWDPkQNL+tIdqTI57d8iapEXgXMAudQbGvEiP3d1NJU4wLv77JO4n6ReDzxQAvF
         w9YupmcprjuOPn/ZiXrWur1LsaUhvSeZmR32OFmaCA+LLlhf55touztQn3b8Rw686/AW
         GYSYaK/FCkxrt87bhJ8j2aP/KyBDadO7Eb8zQStIMR9yb8VamSUJbpRSEjeLtEbx3R1P
         C/zA==
X-Forwarded-Encrypted: i=1; AJvYcCVa7c9PWBVg7kAZhE56+tZBaqNK3KY+2I+iiYu4KXiw6X0CJ6klf/sR/24sg8509lZ8oM2scxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp6GHjBZdT1rXGmwLsrGjZesI4y8wu9tH9yrdEdFUR/C4fxPx1
	4q8L8skbflIRs35F4gD/5xPftHbZ8biqcfETrQ1bM3wQrXZpR17JdqxFJVQJvXma
X-Gm-Gg: AZuq6aKcjQJU7MV5BB7cVFIkVU32Scr6otWC2L4nBvevFQgV5cRmKIlZOHkEdZgVawz
	tiin+TL3trA5gTKvFyPvDmClIS5Ls4HgQD+F4RBsOJBnCNqJ9M+noSNWPXjxeMSDY+0B6wbFqu2
	XytJ5MC0dxLNiaexaiJiWEljDuT/9UQOdxQ9guDxCNSBD+v/HzaSJKghaWPH12zSWZZjvf+3ARv
	c5afv7F6nVP1u+fucJO53+37gmeOSjyj9UP4cJy6W5m6FDpQdodnlJYrZ0mBuY5UMia7HSDEAdS
	cJaw4ZdrenyzC9wsZwbrvNz8P3E/cBN3ycz2/vCjpeSElpfiYShm1LDMOGYa3hOcvJ789tNp6o6
	xLvfWW/El7y7JtCkm+BnlE+vd+Qvmg7WJGb5eoc4FHSFJ+3a6LNN6mhK02BjVO/P8c8WPpQWpeA
	bmKzf0SIY1V9Oo7adDl0JO5viqY2WDVO63t5h/uwM16FCgQwzkqV+9KcersH4V
X-Received: by 2002:a05:6122:1d4c:b0:566:2302:f317 with SMTP id 71dfb90a1353d-5675b7c9ae8mr741212e0c.20.1770910117777;
        Thu, 12 Feb 2026 07:28:37 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674c2429c9sm1819707e0c.16.2026.02.12.07.28.35
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 07:28:35 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5fc66c49d03so1605561137.0
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 07:28:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9UXJJtZDYWWaBezejgUsIJxBmp1LAAtaqP2ox4kZirgUhlbne+2pS84HUI06YXdJlwzN1snk=@vger.kernel.org
X-Received: by 2002:a05:6102:26cc:b0:5fd:eb2d:e714 with SMTP id
 ada2fe7eead31-5fe006b511fmr835506137.22.1770910114712; Thu, 12 Feb 2026
 07:28:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206-nbcon-v7-0-62bda69b1b41@debian.org> <20260206-nbcon-v7-1-62bda69b1b41@debian.org>
In-Reply-To: <20260206-nbcon-v7-1-62bda69b1b41@debian.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Feb 2026 16:28:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUVzSQv=Zw7qh3UVYftdb=Am+URJ2dJ9mwD3WXbuNRT5w@mail.gmail.com>
X-Gm-Features: AZwV_QheoIK05fsOpIY7usPxMKv7SFALLCN-Vk5kXX3MLafKpNUG4FK9VCekOcM
Message-ID: <CAMuHMdUVzSQv=Zw7qh3UVYftdb=Am+URJ2dJ9mwD3WXbuNRT5w@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/4] printk: Add execution context (task
 name/CPU) to printk_info
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	pmladek@suse.com, john.ogness@linutronix.de, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, asantostc@gmail.com, 
	efault@gmx.de, gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, 
	mpdesouza@suse.com, kernel-team@meta.com, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,suse.com,linutronix.de,linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,meta.com,lists.linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258468-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E649E12EFE5
X-Rspamd-Action: no action

Hi Breno,

On Fri, 6 Feb 2026 at 15:39, Breno Leitao <leitao@debian.org> wrote:
> Extend struct printk_info to include the task name, pid, and CPU
> number where printk messages originate. This information is captured
> at vprintk_store() time and propagated through printk_message to
> nbcon_write_context, making it available to nbcon console drivers.
>
> This is useful for consoles like netconsole that want to include
> execution context in their output, allowing correlation of messages
> with specific tasks and CPUs regardless of where the console driver
> actually runs.
>
> The feature is controlled by CONFIG_PRINTK_EXECUTION_CTX, which is
> automatically selected by CONFIG_NETCONSOLE_DYNAMIC. When disabled,
> the helper functions compile to no-ops with no overhead.
>
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Thanks for your patch, which is now commit 60325c27d3cfe134 ("printk:
Add execution context (task name/CPU) to printk_info").

This increases (the IMHO already large) _printk_rb_static_infos
array by another 40 KiB, according to bloat-o-meter:

    _printk_rb_static_infos                   180224  221184  +40960

> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -341,6 +341,7 @@ config NETCONSOLE_DYNAMIC
>         bool "Dynamic reconfiguration of logging targets"
>         depends on NETCONSOLE && SYSFS && CONFIGFS_FS && \
>                         !(NETCONSOLE=y && CONFIGFS_FS=m)
> +       select PRINTK_EXECUTION_CTX
>         help
>           This option enables the ability to dynamically reconfigure target
>           parameters (interface, IP addresses, port numbers, MAC addresses)

I guess we should start disabling NETCONSOLE_DYNAMIC in the m68k
defconfigs...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

