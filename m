Return-Path: <netdev+bounces-250636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF809D38691
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33E883013551
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC6F34CFA8;
	Fri, 16 Jan 2026 20:04:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D363054D8
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768593894; cv=none; b=RTMc8Oi80FrbnAvnz6AKjlQd+FGsL648WDnH5Pg0vs+ioq8riTtXe1AzCPpOUjsKlo2VvRjMR7Ey3g6yk2LCUKHekx2ifAbzJ8/+w24XMpHXqDySiB2ZwJoAyNb0Gzt4OQOIx7rxJcwQB+JWrPLmNDUftImveg9XOclFZ3uTU+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768593894; c=relaxed/simple;
	bh=K6LdsqUXrNUwOQjRda+4TL3J9Tvwpa+riyhbDUqJr3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7x/ZR1QJjmHY3Rfmswy5n2CbFAC7yVOxr+EBxFAaZy5EaXiJSXhbWObFK2X+W+kRWBFxM7SvjKyOUs5yOypH7FnADFqxAvFJhHfkS2UBvWgPv4e293xc6gJZ+RgKRbWCyIpErdJWzP+vimjuNJODL+ttjkyqoHx3WdowTF0Vgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso5285746eec.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 12:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768593892; x=1769198692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJgMpRp84niyMMb5pn3Lj6itNx/z6RtbQINRzPFwtgc=;
        b=NJpB5XL8zbo/1wNIDKlXi1t9K5VdkhzF4OnmQgOqYGP1erbpTHu0z2m45Z1CVJDHY/
         Yz0EPXzNNvrUStLiI8pyOqFBff07mjR6gexGwK6LBbxyXvu9kXj01S/acHfNnOo9ixQ3
         Fg2T2C6mqYT4akMwzsJLz9z8klsoZAa4hbswuzcxXRa7xcgHAvE4MukQLoTYpAGGA9vE
         AH2NuCCtmZwUD9nnXQyCn6s3WoFRM56iiSBubwvwp9/T9UTyRQQZDN4OqHScLayR9Y71
         XEErixRSUsEf4pY9IQ8TjzqgmSG2rTM5tiYuEIrQs44Wf9rNf6YRVapsp1PkHAkX5iXf
         yeaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU11NzzpVELBpa3RfhAINbeDcyCloCftWRX9t2SA/SAzexUctKDS+6qPxsm2B+Q7Qic/Z8hZQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkqIbpaH8AB+0WrWkarWKBVi1Hflo/fPO9qecppiR8lKeZSfZf
	QmiSvGic/9azF/o/26XTAZN3ufvrxFlxmSHJumHiBxpAHIqH6Fkh5mcH7sCaqQ==
X-Gm-Gg: AY/fxX7kovNOXtzr8JPhoYVw+6QpMLLY7N0ikk54pEBW8pkNcr87yZ+ZKgM73WXx6Iw
	3WLgKzJgkBc3pRj2Qsz6VeScK6Euvj3m6wzQHRlGuEuVV5NVEZksxF6ft8BhhnQiwTaTGEMz5D7
	cDJXtvoMxn86Ga/HJoi4bNaRB6VcRmIyQDTNL3ojCSMQRdpcs4/RRLmt3+68SkkhRWOXikSQudT
	CHwvNZbUxM4Fuzs6oP0qoKZPbLY+Bpl/nJMwQHqwV8wC5YuG00hs/pmM9mEYuaTVmAt8WXHyvzT
	Uh1nxGZvPVQjTILW9VRwKZ03sxT2sxZ919HhgYkA+0+TlnaltC8AN03C3ITljfXHw+gsjUMjaNf
	LV+t7ebehGcxzKA/OKFusMgjGLNEd8+6NOVUEWsFGABNSzf2WANY9CjS63Q8b+G5txfsHOAS03r
	1L
X-Received: by 2002:a05:6808:1b23:b0:459:9fe6:b16f with SMTP id 5614622812f47-45c9bf57251mr1551727b6e.23.1768586830992;
        Fri, 16 Jan 2026 10:07:10 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9e03dff2sm1636081b6e.17.2026.01.16.10.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 10:07:10 -0800 (PST)
Date: Fri, 16 Jan 2026 10:07:08 -0800
From: Breno Leitao <leitao@debian.org>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, osandov@osandov.com, 
	mpdesouza@suse.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com, calvin@wbinvd.org, 
	jv@jvosburgh.net, kernel-team@meta.com, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
Message-ID: <6tryrckp7mah2qghxu5fktrwexoik6anplubfvybushtcgocq5@kg6ln44istyk>
References: <87zf6pfmlq.fsf@jogness.linutronix.de>
 <4dwhhlnuv2n3f7d3hqoulcnsg6ljucd6v47kqcszcwcshfoqno@rzxvg456q4fi>
 <j764nuipx4nvemd3wlqfyx77lkdf7wgs5z452hlacwglvc2e7n@vsko4bq5xb2f>
 <87eco09hgb.fsf@jogness.linutronix.de>
 <aWECzkapsFFPFKNP@pathway.suse.cz>
 <875x9a6cpw.fsf@jogness.linutronix.de>
 <44upa7szd563kggh4xolznmfcwfnhrrh5guvecp6pzlvp5qvic@w7hxtzy7huzf>
 <jakydyx5dprrzgbsb6lorgpova46jbhq5tecwwtiihkhyi6ofy@olsrizfk52je>
 <aWpekVlhRpD4CaDI@pathway.suse.cz>
 <aWpfDKd64DLX32Hl@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWpfDKd64DLX32Hl@pathway.suse.cz>

Hello Petr,

On Fri, Jan 16, 2026 at 04:53:48PM +0100, Petr Mladek wrote:
> > Otherwise, it looks good to me.
> > 
> > I tried to update your patch with the above proposal to see how
> > it looks and I got:
> 
> The change seems to work. I have tested it with the following patch:

First of all, *thank you* so much for spending your time on it, this is
helpful.

> Then the extended console format should show also:
> 
>      ,cpu=XXX,pid=YYY,comm=ZZZ

Are you using this just for testing, or do you plan to get this output?

Context: netconsole outputs the message in a different way, similarly to the
printk dictionary. I.e, taskname and cpu come after, one entry per line:

  <message>
   SUBSYSTEM=net
   DEVICE=+pci:0000:00:1f.6
   cpu=42
   taskname=NetworkManager
   ...

I would like to keep the same format, given users might be used to this format
already, where netconsole grabs teh cpu,pid,comm data and massage it before
outputing. Something as:

 static int sysdata_append_taskname(struct netconsole_target *nt, int offset,
				    struct nbcon_write_context *wctxt)
 {
     return scnprintf(&nt->sysdata[offset],
              MAX_EXTRADATA_ENTRY_LEN, " taskname=%s\n",
-             current->comm);
+             wctxt->msg_comm);
 }

Here is the full patch I was using to test the integration of netconsole and
the previous printk patch:

https://github.com/leitao/linux/commit/4175dc10719a15844b3a0bd7aa38158a913181a3

