Return-Path: <netdev+bounces-260697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGJhGyFPnmlIUgQAu9opvQ
	(envelope-from <netdev+bounces-260697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:23:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1518818E9F5
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD282301DEEB
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947902517AC;
	Wed, 25 Feb 2026 01:21:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E361251795
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982508; cv=none; b=jfVmG9twGa++rGIGMgF6jCsyHeYtG0odBIQdWaxZANBpzjalusueP/WsIBplsdZnR/3/+3Sb6DcasFU17/FEY0EgzpZqouqTpMUeB4h3WOhEavH52CVripArqa0rlUqrckrTVTdmmufLq7ZroFBXhRLvb5CL7wkt32zzoxQFsOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982508; c=relaxed/simple;
	bh=yKovwIdqPRgsrWJZruxearMiFkjN/rWy1j4q22X0Aqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7pBmN3tswA0DtjlNn0unBgMTPvH23HG05PYhr2NvgMLQKcvy+rMK2/P4g+M5AEBV47jJllijQg7tk1fIfCnRRDJOI4mrajXX0TtmVkX6JU86sXLwbObyCo/VN+9CZjpLunOVCwHwY2gE1YQl4Xv9twRGlHqBklokwB6iGcvC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so5776232d50.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 17:21:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771982506; x=1772587306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QdkxFMhzm0Fp9FHvcBTC1W/0v+EdFXrgNGwYB4/cinE=;
        b=f03w3+rZHbK7d9cIGpL37faXOCa3lb73XH+IzouHe0boi63Wwy0KloZPBfkcgZjG1v
         Bqn338L0dUTgukFtu/Rg5zDfTSeT+l+nviQz0OE7vHyNBHELv621x6EjqyG+dlLducpo
         qymmmvkyFIrAXwSLD4eqEfwB/tR3C3LjDm7OD5zkm3nZpRVnH/3vsu0uc8nKa8M0K+Xz
         nPYlTo616ZPBC/zNVLLLsIWr9zbhsBap2ca/+UYUPJGEOQ7eYYf8sw/Bme/O1M5gJFhI
         1csTl+yCUBB95tuJmPogJ19sGv4VC5cnX2I/dlCaM9kOhKnJyZft3lhzI9BRTMNfi0Xx
         6YMw==
X-Forwarded-Encrypted: i=1; AJvYcCXJRKn5O/uYuckT2DUMHxUmyhqsvmWmDE49PdKCqm+x4luwpnCIyGfTkv+0ebQh0dK6FT7lBWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZd/GYT3xMIuB42eBcB1aqN/Q6snzmXudNlGKLHKMU3hHN5Lf
	H9tpedPlGi3/u3uJo8VRlnoD/wU+1EMvNXG7sHHMZr1p0CAN5Ig/4RfYKn2aO7d2qqw=
X-Gm-Gg: ATEYQzz/gqgnaGX9CbhY4TXRa2qtuqC4qc+5pa4tJVuZKR9Q6BcNiOxyudyxdTv4niT
	o3rq8MOQ7O5LL1v0tXODaHd8vGCNzgO5gvQvf5Rr9faCQwfYAZgFPWiAvHTKcIMr5UleNkJkQPx
	CCaQitZYShsuN9JoP6km/cyj/Mm+/meUBnxsFRzMMPzoHbigLtfOKVfgX9HH5uuR/JVPHViDDN9
	Tm/flNnJYKYsToL4QSe1Rnwk1GaW+15zTH4crjt7Iem1K87CmGmSP5ML5dC6uQjSMS6EKTCD5Ys
	wgrMGV+7fbCYYhIlW+v/V4pkCBYgTBY7AIBCg230I8gLOi6Nq6xCMK4wFJ8dOC6tx+cH5CrG8Gw
	6o9xGPnSGU1y1osSC1t4glDcodRjv0lYmhWdKDyO+X7EZfF+FwvHOi1ufb8ZGf9dCdDYDIqejeJ
	/S7DgPGkJ/ftwTQ0Rb3+/nnYceRo3FRJU5V4ERUBKAFr4YhTsUL46XYoGtpoTj2NG0RnAvbeqS/
	yrwV0jUxCgonzg=
X-Received: by 2002:a53:d88d:0:b0:649:c36a:a9b4 with SMTP id 956f58d0204a3-64c789c78b8mr8416728d50.36.1771982505997;
        Tue, 24 Feb 2026 17:21:45 -0800 (PST)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com. [74.125.224.41])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c7a138035sm4986057d50.0.2026.02.24.17.21.45
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 17:21:45 -0800 (PST)
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ae222d87dso5593220d50.2
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 17:21:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhzSdZEYqK66ge0SCo2lF3yXg0Q9jKRUim76vZW0NxqaCEngw+HZsek1Z2E8t9YuTUFNg0D+E=@vger.kernel.org
X-Received: by 2002:a05:690e:134b:b0:64a:d67a:1fdc with SMTP id
 956f58d0204a3-64c785dc781mr12465473d50.13.1771982504630; Tue, 24 Feb 2026
 17:21:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-netns-redundant-mount-v1-1-0b1ebfc1c79f@black-desk.cn> <a9197cec-d406-4201-98d4-a06820b220f3@kernel.org>
In-Reply-To: <a9197cec-d406-4201-98d4-a06820b220f3@kernel.org>
From: Chen Linxuan <me@black-desk.cn>
Date: Wed, 25 Feb 2026 09:21:32 +0800
X-Gmail-Original-Message-ID: <CAC1kPDOs4MP0=89Aa=Y_nZmVY2_9WUgfQs0x=wd-FPMFedrVqw@mail.gmail.com>
X-Gm-Features: AaiRm53PWz4RhpOCZJlKY--hwEjndb_-EGdDZ1YrqJaiXdKMfovD2twVPVXLlhA
Message-ID: <CAC1kPDOs4MP0=89Aa=Y_nZmVY2_9WUgfQs0x=wd-FPMFedrVqw@mail.gmail.com>
Subject: Re: [PATCH iproute2] ip/netns: avoid redundant mounts
To: David Ahern <dsahern@kernel.org>
Cc: me@black-desk.cn, Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Lennart Poettering <lennart@poettering.net>, 
	Luca Boccassi <bluca@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[black-desk.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@black-desk.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-260697-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 1518818E9F5
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 11:24=E2=80=AFAM David Ahern <dsahern@kernel.org> w=
rote:
>
> On 2/9/26 9:11 PM, Chen Linxuan via B4 Relay wrote:
> > From: Chen Linxuan <me@black-desk.cn>
> >
> > On Ubuntu 24.04, I observed redundant mounts after adding a netns with
> > the commands below:
> >
> >       sudo ip netns add xxx
> >       cat /proc/self/mountinfo | grep /run
> >
> > Output:
> >
> >       29 31 0:26 / /run rw,nosuid,nodev,noexec,relatime shared:5 - tmpf=
s tmpfs ...
> >       ...
> >       203 29 0:26 /netns /run/netns rw,nosuid,nodev,noexec,relatime sha=
red:5 - tmpfs tmpfs ...
> >       6443 203 0:4 net:[4026533578] /run/netns/xxx rw shared:917 - nsfs=
 nsfs rw
> >       6444 29 0:4 net:[4026533578] /run/netns/xxx rw shared:917 - nsfs =
nsfs rw
>
> with this patch I am still seeing 2 entries:
>
> $ sudo ./ip netns add blah
> $ cat /proc/self/mountinfo  | grep blah
> 337 92 0:4 net:[4026532418] /run/netns/blah rw shared:344 - nsfs nsfs rw
> 338 28 0:4 net:[4026532418] /run/netns/blah rw shared:344 - nsfs nsfs rw

It seems like your old `ip` might have create the /run/netns mount point.
After remove all netns then umount /run/netns, and ip netns add blah again.
You should see only one entries.

I don't think we should consider correcting the mount point created by old =
code.

>
> ...
>
> > diff --git a/ip/ipnetns.c b/ip/ipnetns.c
> > index a20cd8bc7cb8..3a33a3adacee 100644
> > --- a/ip/ipnetns.c
> > +++ b/ip/ipnetns.c
> > @@ -846,6 +846,20 @@ static int netns_add(int argc, char **argv, bool c=
reate)
> >                       }
> >                       return -1;
> >               }
> > +
> > +             /* Reconfigure NETNS_RUN_DIR to MS_PRIVATE recursively an=
d later
> > +              * MS_SAHRED again to make sure it is placed in a new pee=
r group
> > +              */
> > +             if (mount(NETNS_RUN_DIR, NETNS_RUN_DIR, "none", MS_PRIVAT=
E | MS_REC, NULL)) {
>
> line is rather long. please limit line length to about 80 columns except
> for print strings like the next line.
>
> > +                     fprintf(stderr, "mount --make-private %s failed: =
%s\n",
> > +                             NETNS_RUN_DIR, strerror(errno));
> > +                     if (lock !=3D -1) {
> > +                             flock(lock, LOCK_UN);
> > +                             close(lock);
> > +                     }
> > +                     return -1;
> > +             }
> > +
> >               made_netns_run_dir_mount =3D 1;
> >       }
> >       if (lock !=3D -1) {
> >
> > ---
> > base-commit: 72f679c0d07629fe9e462c2c52bbe48aaeaa7f83
> > change-id: 20260210-netns-redundant-mount-aa2db50eac7d
> >
> > Best regards,
>
>

