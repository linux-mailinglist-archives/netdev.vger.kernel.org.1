Return-Path: <netdev+bounces-291926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nwFkGK8IFmqBhAcAu9opvQ
	(envelope-from <netdev+bounces-291926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:55:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2465DC80F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E301A303FBA6
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E783C0A05;
	Tue, 26 May 2026 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BiQ+/ToJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E21926C3BD
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779828851; cv=pass; b=jnYWc8unfDaerGUyUaUfDy9Wi0kLYmP6AT2lXTgzyd7xO+FcF6EtsI+QC1XqNR6Rd7YO0pR/3qEEA4/F/TkUVX8HzVFA+w/YNdgTDArw7Q2yii03ct0iLvjbljeCjE2CNSoy21VGjVI1ZZ93COQbb27Pe8vYhcSNYkTAd0jLSVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779828851; c=relaxed/simple;
	bh=g3tAHZlmjqVB8F58Yb4ZWVoVwqFrZlKYWsPBDFTsCxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlmCpdq5hm+XeDO6xSipWiocSDOwNgKf9AErEMhrVx/43hLdLYcWwljyrG0fSUIibk8rKwdCjXpHnp3fiHAZpEKw3T85+/oNy0V5hzKzRMkiGasey3s8Qry/FsHeOMjKFmTf4/1pJ3L8CyiQgYCWmSDk58O9Kzl7NzudiXsaGe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BiQ+/ToJ; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-366375c4076so4774793a91.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 13:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779828849; cv=none;
        d=google.com; s=arc-20240605;
        b=K+5B8/OnZueCZ8hQ1i/S9NhXOUE0qNwu/0a30b9tzJKKYbqP/IZuTbEY6pcqQ9uFHq
         XxEkCrT3ihvXEyt2vd6yHZPmUw/aKj/fgBzcVrFQGajDFQxvgSm6hp8wuAgcyLy5nszc
         9fAX+qpEAMZXuG68RdihSbZGbk0/W96WOWbNAgr0/6mdeJwiwSv/UBit9j96h0uO7qul
         bFHtS8AUOQCEQ9+QjnA8MOsEppOBsqQ5ArRcaKUln5NMHHHOi75QfIJDpn8r5zZJIIxc
         03RsV7Qp4ZWXVFeNgNru4Qfd0Wa5HvQ1c5qCgAZXNR/c6Vj86U1ftVz3esfxLpdTCoWE
         FquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cKoGVXp9VQvZ/qhGKuiAhQLobh3aS2Nh5IGMtLCVpaw=;
        fh=w+oPBCSbNeQWbB15qMFeZ7kiUbTooHiYpYMqfZ3hNnk=;
        b=UvR8PZT3LzLGdCy/zrt99kqLC5KPXS6Us8sZAZnLUIaZMluxTg0RIn01aAEPgdBaAX
         YujhhEn/VjuXz9Y5qzT+3tTJV5ARMN7cN8sHD5dX4pn1E/gJMCTmGzPUaL+eDQ10bEMu
         aE9RYi6SwiwmYh8GVhtKZMBTQgZmgJVgbE6mU2hpgoaccCA6Ir+QA4yxWlKCTgbVM5kI
         AK6tdwotC4FF2bqniuhEiRit/SdVSeeqb+FNy7Odq7PE/1AEvFdrCfZlxz1DVajHeiDL
         bS61cc3pVAbfRnr+5FMp7CamPKdFY+PRMhv6EkLKVnqPJ2gdHXe31RVH/6N3r1hhnx2S
         AI0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779828849; x=1780433649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKoGVXp9VQvZ/qhGKuiAhQLobh3aS2Nh5IGMtLCVpaw=;
        b=BiQ+/ToJHIOJ55puvWhOri2tKGmpGGparX1e0GFnXBYuKD7cD7HLhJL3/RT6x0k0Mc
         +044LWaf0Eqo7dHy7ZyYq8VqldtRi9TbiHejuNUccz6K2v+LCrm/Fy/2BjqrM4S7lnmI
         aBUslhqQCdLC3FN0OkvXqPRTIy1AB72PAg9Y7nzZ1jnptayjWJWj/dCtzl8pp43eOkIM
         eAfvfpHuIGiYtfps3WrHxfMEeMr3BA4Cl1plNDuCpUWZpU2KAUHOgGFo+ToiShNlSxUk
         GZNsyD/L5id63VoJWhlOBlA8X7qS24HRclASh0sXi64rcqwQCW8z1X+RDaprUwwd8WA4
         8Z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779828849; x=1780433649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cKoGVXp9VQvZ/qhGKuiAhQLobh3aS2Nh5IGMtLCVpaw=;
        b=DMUzvC6lrgX7XU3o4bPU80GHR89LHhMU6+60/IQR6CNnHnDCg5ZFqciDuabHFU6e0X
         9HK57L8JyiZaNxLHGSW0UJXAPwuxrOscUM/geFGQJMfH4xOlhxYgUtU7eV5ny5+dWy/c
         BcnI7IOpKweGtPw/34KYSzATt7XvjUYYLdpeHrIru8z6NjNpoiqkFanH3+KMrIE6ee5U
         KTdrNo7dE0a3ph0N9HVOo8iAVaCCclYkg4XnrMAG45G0QYRtMp98v4pFqHpOqiQgGW2W
         ccXwIU0O7JtP6ZMopEyS6w3VIcvxXMWoco5hfiR8STLLofIWu9uxjUR04Ms7gmLCpTii
         yz2g==
X-Forwarded-Encrypted: i=1; AFNElJ/V72Y5J6oXaoPXtCgqkFEfFTrhROBl6w2qcXEUsylWJ78SwDQKG4Bvxu3depgayoHyBI3fm9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJGXOEQa0FrFE5A10iN6CMaLshahWdBP9ODlox4AFtHpi8jc0
	IhCFtkX2sq0uS2VZ0Sezl/XC7Fvp3uLkDa8z10OcLkmnHtsSLC2/9ddWaG9wcNwzOfCuqoun4Wr
	SFLnUmsH8zTDSXw05LLG8CIOQt3gxwfwQZsExMMqh
X-Gm-Gg: Acq92OHjzK8frutQ6CNatEBHWyBKLzZJ8Z/3CHSvwOz6mYmAwuMNlncFny/fzc9IQzj
	6PtoXv7gZnEiRExH6fVJS1WtszttuBF6uwNbtbJY8CULyGbXE71D8g/nw9ibkrpDKbWE4Ze5Jb7
	kaTXP213oprS8yKuUKzh0hW7lWdtLybOZ4p2UO/+OrIh44cBW2jPKhjYpPCruMbom/mbRmbjvg3
	ZMMqZD/TFgQeVbgeJF8jDnZTbYg27+/1bGicbFQF+JrfTCB/J/3fFVebVlF3Fsxlzmp7KcXz4QV
	n5xIloE=
X-Received: by 2002:a17:90b:1a8e:b0:368:78da:803 with SMTP id
 98e67ed59e1d1-36a674f81fbmr20198798a91.12.1779828849269; Tue, 26 May 2026
 13:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513172443.1128496-1-rrobaina@redhat.com> <20260518173507.2f2529c9@kernel.org>
In-Reply-To: <20260518173507.2f2529c9@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 May 2026 16:53:57 -0400
X-Gm-Features: AVHnY4JL0a8xLE4fxERdMP_DngilckfsvKCCxAGn7xyy829c-DKtroKv7TSAUyk
Message-ID: <CAHC9VhSs5MQ5sF6rLGVDj=jYJXnUM2omc5tG+7ELkCg9t7aPMw@mail.gmail.com>
Subject: Re: [PATCH v2] netlink, audit: prevent false ENOBUFS on timeout expiry
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, eparis@redhat.com, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291926-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AB2465DC80F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 8:35=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> On Wed, 13 May 2026 14:24:43 -0300 Ricardo Robaina wrote:
> > When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks on
> > the netlink socket.
>
> Holding socket lock during slow IO sounds very wrong. One could say -
> that's abuse of the socket lock?

It's no different than any other kernel subsystem sending netlink
packets to userspace, although in some configurations the rate at
which audit sends netlink traffic is likely much higher than the
majority of netlink users.

Arguably, audit probably never should have used netlink, but that
decision happened a long time ago and there were other issues
complicating the decision.

> > If the wait timeout fully expires (timeo =3D=3D 0),
> > netlink mistakenly interprets the zeroed timeout as a non-blocking
> > request. It then triggers netlink_overrun that drops the event,
> > completely bypassing the audit subsystem's internal retry queue, and
> > falsely returns ENOBUFS to user-space, resulting in the following error=
:
> >
> >  auditd[]: Error receiving audit netlink packet (No buffer space availa=
ble)
> >
> > Fix this by detecting when a blocking sender's timeout has expired
> > (timeo =3D=3D 0 && !nonblock) in netlink_unicast(). In this case, inste=
ad
> > of retrying with timeo=3D0 (which would incorrectly trigger netlink_ove=
rrun
> > on the next iteration), safely free the skb and return -EAGAIN, allowin=
g
> > the audit subsystem to gracefully enqueue the pending event into its
> > internal backlog.
>
> The socket _is_ the queue, normally.

There is a joke in there about audit and "normal", but I'll leave that
as an exercise for the reader.  I will say that audit has a lot of
unique requirements regarding queue management and that dictates a lot
of the wacky stuff audit has to do with it's record queue; the
standard socket buffer functionality doesn't have everything, and I
wouldn't want to ask for it to be augmented in a way that satisfies
audit.

> Please explore fixing this in audit?

Ricardo, I was kinda hoping not to have to do this in audit, but I
think you can probably get away with just open-coding
netlink_unicast() in audit and then going from there ... we might want
to do some other things differently, but let's see what a basic patch
looks like before we spend a lot time redesigning it.

--=20
paul-moore.com

