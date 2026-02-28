Return-Path: <netdev+bounces-262143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIzkFnsAo2kJ8wQAu9opvQ
	(envelope-from <netdev+bounces-262143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:49:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D461C3AD6
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CBA53068ED3
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA6543D512;
	Sat, 28 Feb 2026 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZVMeUFb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902FB43CEE8
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290015; cv=pass; b=i2xaopzuIfsuf221cyrtFSbYwd39zRzUXY+XKeuZCEeLJViiD79cvkImv/hEzhZA5+6ooRJJ0Vwf6K6hRI1tawiVqzWh1IcNdA1T1GSjwRxRje0PDVsyR+DYK5zucFSrtjJFnipAw8Q5htiqxli+bPYyiNM1IwpE7UMEPI/nWxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290015; c=relaxed/simple;
	bh=RyIy3tfr9dhAMxJMTw7hDYdVXghZTOo9WZOJGFBvp1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h11GfKN8OGehvfQrcxR6X5ROLUsAjdQ4f+hW10ibT/HkrmNwJ2vyPafZ00646gMpNTenBGAajSVrxdf9DEFEM378cPyq1gEIm7dGsVyMfvLw/Svh2Xp2mKqpGVy6jqEs+74Vfg/yL+fB217UgLh2b7Qn0ww5Cf28CdW1IbkqKOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qZVMeUFb; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506a747448dso26987641cf.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 06:46:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772290013; cv=none;
        d=google.com; s=arc-20240605;
        b=ZGSuW/3V5ebsL89I25RXRkImrvnyklf6Mtt7xvpBhMLbJy3gzjaKCP3FGLnH7b1Aml
         MlR5CPmoUJn+HxXMit9uoDu2ZEm8K9LC3LL+BBUIXWKwxnEDsczkNuKIVm1eIRXNJPj3
         7VFe2XQCmwTmFLAPUkb/JN89rgoJFW0fDHYzk+0AEKNexarkhBj/G8CbFm0SCd3D09RF
         QkTaRwEJP2yyQEP7VyjhShzTVpb+P6g46zTCBo1xv2joSSG2TsxHJSVbmobgqvBmBPvT
         Wkq0oLAmOSzSscBz9c5PbWN2lIZsOEBZC3fo/jR/JFZ6NTbaYelwO8PLWstM7DpBX+YU
         NL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7RPz7Lrd2QO0/SbJwAO7j/st80ftlOvLZX7cK8HYfWg=;
        fh=twjZY8fbuKpya92wLWU8VuEqqiJ+xGv27HtkCjROeIQ=;
        b=hqAN84xL3z5VsouCnRRr+ZIMmCnZDAUdZUthRUxwnk3ChD4DjH97dhIAXWu2Y7RfxQ
         1nrZApJWFf8zHVy5mt7ez1Cx1+Rcr8driXef0mlXEQI0bxXJ5WgwDl+8hvnGOiybJxHN
         WAcCA5VJq9SpPhdxvKERvsDlm5dloDpaWuqbPzhh9tFqg3b8wIimdYVLXv8QNvE62owB
         JngdsuztDD3htRy9TG5WmQPW8CeoBSuOP6IwptlmXhjJEpQn43OYRaWh1Hq+RJoAjuW7
         BFyEk7pVSibnWB3Ze8jYCqDijEFaG46VIvGVOkrjTf2BUIcXmPkwrs8q2H8isBgE7+V4
         mtcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772290013; x=1772894813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RPz7Lrd2QO0/SbJwAO7j/st80ftlOvLZX7cK8HYfWg=;
        b=qZVMeUFbmjwGM2W/o3N2nexC6D3LqaVNVjEGbn7+a/8g9Ugx8B06YCNvUZEReWoyG7
         LpyrNcLj3hXMTOHiYDD4bkK8RcV9mnmyz0XeYofCO1k9SN9sfGyEQ4cZg58vwxn7c6Oi
         /Wg0otmOY3Z7ChxvxZxkXWHtVVzj4tXFQGhqTDrP69bSf/IsyrdGvkjSMfPktVaNUDqm
         fbOCq7EbyUKkXahBv9vtNJXE8GtsAYDn+9WZBZN8trVnT6n8DJD++gSkqlqHqu0l73hY
         9Qz28iuwDtnDMV+MNSxX9AZ2KxxeY+tKSauivd4sKrzuEObPVnBFKynyoKB4Rv4BbJ+0
         2NQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772290013; x=1772894813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7RPz7Lrd2QO0/SbJwAO7j/st80ftlOvLZX7cK8HYfWg=;
        b=Dv0gime/1Ie2uEaHoxNOI0IycjnWCHfaM/auwvUMBxw3zxYMrv1L4w+IU8Z8QY318n
         CSQ9g1kgXoHLURp4WtNLZ6FsKGmnUc1pNR/kcbF9/L58jU3O7pyF3FX2Fn6ZNkpCTeIk
         a+Za1ByjJgy5TB0AKEglAQ6guybWjAAQROyIrMCJ6WyTyohUsIUi/vVLzXy4PeI2DVfY
         DbSk1988+kUiK2H1RKzvugo1s7irX0oR5OYAiBkfXRgCuoXwPZDrCDGxk0Z7EOh7tbfL
         BL+dLWaXfUXpaGmUiHxJN/+RW/pRVuGQtr3fTsDHO0TO/sRSZSLU4JZXIUq1QOw+OjrR
         /agA==
X-Forwarded-Encrypted: i=1; AJvYcCW7yjc1sskf/jXbGQqOk0F8TztIz+E4TLsOJTZF92D6rRv78q9ZGqW21/oR2O3HykocTKz2+mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRfPm8VELcQwpaHxzApHyZZzyMBPTk18sfGlBTpAP+45+YMyUA
	pmzp781xLiMRpMUWa4pa2MREfoBxtKtTnUpFj47O8ualKJ2mjpvR/STmJsyp3S73JkD9QefvPZ1
	6a5SuQB49qjfvXE4hacbRdl5yRK6AjVQh6ZCPPWYb
X-Gm-Gg: ATEYQzzP4MJC+eCBaG1+gJHnEdO7Eom0o1ZjILIcrpBIHZh1WrQYAlaykWbABTQ2Ga+
	Wz8vGix2h7G3YundxWXX+KXyUtNaVOLqVuH+SGzVqA6lrbG8V2XS1UnsMdVds8AJ+Gqt7tFcMI6
	sJ/Hzm09xi2VDCi1yZOQnDj58uBDmKcfsGyYUaCt2RJz+HbDuy2qKkpGXPX48nKJsgLhYKX72TN
	TNjvtjQZYMHrqInbDnPpAGJqz95UnB/X7cKolMhhS/c1aw2PDUvd73G8ifS1id03zCYSgk6RCZN
	DcvTOamu
X-Received: by 2002:a05:622a:356:b0:501:4d61:f02b with SMTP id
 d75a77b69052e-50752895c07mr74034971cf.59.1772290013092; Sat, 28 Feb 2026
 06:46:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com> <20260227033903.3307272-6-kuniyu@google.com>
In-Reply-To: <20260227033903.3307272-6-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 15:46:41 +0100
X-Gm-Features: AaiRm52fN4Wa7tlKWDwyzcDfUT6guV8HM5j-P6R3ZOaGf1Wp1cOpN8KvR9z6bxA
Message-ID: <CANn89iJqFh00uu3W4RPsN3pcFjGmb3tpGd8Uc+WHSzEi50GHBg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 05/15] ipmr: Convert ipmr_rtm_getroute() to RCU.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262143-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1D461C3AD6
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> ipmr_rtm_getroute() calls __ipmr_get_table(), ipmr_cache_find(),
> and ipmr_fill_mroute().
>
> The table is not removed until netns dismantle, and net->ipv4.mr_tables
> is managed with RCU list API, so __ipmr_get_table() is safe under RCU.
>
> struct mfc_cache is freed by mr_cache_put() after RCU grace period,
> so we can use ipmr_cache_find() under RCU.  rcu_read_lock() around
> it was just to avoid lockdep splat for rhl_for_each_entry_rcu().
>
> ipmr_fill_mroute() calls mr_fill_mroute(), which properly uses RCU.
>
> Let's drop RTNL for ipmr_rtm_getroute() and use RCU instead.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

