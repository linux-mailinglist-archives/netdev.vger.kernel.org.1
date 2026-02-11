Return-Path: <netdev+bounces-258224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BgjBKpFjGlxkQAAu9opvQ
	(envelope-from <netdev+bounces-258224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:02:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5E3122814
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BB91301ECE8
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472C532E696;
	Wed, 11 Feb 2026 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBpWPvoL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2622C2F39D7
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800428; cv=pass; b=dJNXcfU0DsGNl1Tr1r99XKuQgA+uGitNC+stzRQvC+kdHa6qBDLyz3Gq5UlSf75y28pcDE2APWJ10WybSN16a7MXmKO4ax8gfSMjbP0+Y8bpxlf6R3lt4kXhsRia57lRtq9BzmPsM7PHQ0rJz1emSEFz6eoHb+5rEqoaAvtPm50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800428; c=relaxed/simple;
	bh=lLa2/wlxLoEQfBV5d6w4ekHKrq1vIwSZn9GGDMyDWlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brjNA4JIUq2rDUGHyWorysOvn1jBnOdYxypJsDsSlor8JQHOBQKO0q2S9HyLDv41dScxUtRQcRalRbxGnwM9Qx6R8bCH/uwJcywIovhfWOBBvY3i1PC4+GInTPDdsBJzFJH92ntBKFfhk6+diEEe3XsO7cP8tW9aq4PSpcjq75o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBpWPvoL; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79627af6349so20155007b3.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 01:00:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770800426; cv=none;
        d=google.com; s=arc-20240605;
        b=fratW2iYbfva0lpkrhEX2j45CXgGcV5DNlr2+QH3w/Tl9QcJRhsHsyEf7A5N5BTWpq
         IzhnMZnVPo73ZK0mUR4hQObrzYmNZpsL/bM23UAkm/UdybzYSMZqTlu7j/TtTcpfuqfC
         3t1aDvv30ZyOMHaGtUe5JK4bL6GIMUvJb59K+sCZZFppe9agKn6saoyNy8I6DDtfeVIh
         kODcEj7b/BbpvhRgFLc9VSns45Ty+a0E5VE6WgXgK1hoR/hyxxkbnqiiFM9z1yfrM8Ff
         fhBVKIN2XYH0BBAQ63AqarbSBlgBQLClZuF4Ktd/MxHSr8wwQZl7QJUw7RVhxn4d8qFn
         bTiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5eBY6DLPg6MqjWFqTvLCRNYv08BwjqlfFLmiBYGbecI=;
        fh=RGx3u+vv9Q9W8JAkh0v6OfdHzyQ5o2pwyENrHh40UHI=;
        b=amsqkmHnWTqwpOEwfW8LBw8Rn0M1AVJk96812Ts8CAvjcWJzjXgG5SlYQQ24lK2+Kn
         MiHVFZEBioysd1zfkgwXFf4nRBjq9isVOYAl9BMiQKrf7VYLT38bSQVDsDSlBcPBxRnU
         WFewIjcvZk3BgEU74cW06C7lhImFcii2ctXsPhINfGeyeqlJmiADC7+zlOrUgozyLCab
         NlYRpx8dNN8oyCBTj9GKVjBwJqwIDwyPGoVI7TMK9KE/wWFKjAr2Qti1rfC2rnUFCFuL
         isZLFughbnuaH1hgPW5L5UXX7AeXRjgEquvouU+/FktBHC173uGDvy+H1CmB8FLxsna+
         PeWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770800426; x=1771405226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eBY6DLPg6MqjWFqTvLCRNYv08BwjqlfFLmiBYGbecI=;
        b=CBpWPvoL3GRLxDDW8sYA+n2vNEgKRq6kQGnTXkTIIeYqTTqeR6iTB0nTok/k6IBIW3
         2oot0xx5XRreYcMyzW9ZchHRinBfFz7FO+3RMQI/3yPMDik3ZRAYWb5Adk+g0f6Y0MRX
         dszgtZUIMTpCZ9mDVg4pXeKomNKetT2XClpZPlbEih/AH88rtZoyShDIqf2YRguoUJhx
         vipS6IAzZLy8lsd9USEYudCioXkUAxBcRD9HfBhsOhSh1mo9DSNz2CYa/kKw22+hD3ym
         UqKPwB/AS3At/dmaHLCyIcwVuVu6MnIN8oKMYCtVRH3fFPSxTctpnYgOXZYhEI0K7dMR
         A/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770800426; x=1771405226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5eBY6DLPg6MqjWFqTvLCRNYv08BwjqlfFLmiBYGbecI=;
        b=T+qtJArEjSPnhu5HcApYXXoD4VLN2ZD/M9iwbImRGYel0eqJ7VzucOnU/+6Z1tHp5m
         vwI3JZN3xtmZOyXLNXXqIM4KS3cQcI5DYl/uS4twoF5c1K9DrhjTFWzHQ7Xltdz49vcJ
         xGAqmEF7UZsdbepxp/d51OmpxYN3tg8XrAO6vEQx56WYGrdVbyWbon6E3w7GR3vUrjiz
         6Z8jTVbHLDY6fB/zmV2n9mHD61+S0DrFqR3HW+rnhCUBK1Zzf0WeKEMMskBa6CpMATxO
         Af/ljkNuOvpAczERizyur4jWI6gB5r+HVur23MhZCs3VtY6Urb4QbviBdL3X5BfGicVi
         xaXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJT6xL8PdNaqPReIEOErjwjNBubVXsu5wKS83XC1b9qRetH3VpoCjYdkz3i73OeCF8swvC2MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQN+68OAmnBYb2wsEJNNv1+cXvCr/w9AoUl8RpojZ068DO4L37
	EuaJKkZBREzxdDPXrG7k0XSZt3FVeS6KKSxkpgoUZmGrMfmP/8tGQXPzA2RLwKuM5JXGYcF0U7F
	W70qmA/hBC8oQXJTTqcmy25EVrbP16/4=
X-Gm-Gg: AZuq6aLtz9O+o2N4RD+2cB7J7nZzEruQgw4IQNKmY32v/Dc92gNsBNahDaJV+nb5+Yv
	m4tW29WDHM68MlPcLum9RiD9+034n996KuqResQ9mP/Eh/LZ2/7BEebqVMdi8JboPRk38RhZV6f
	N7aQSls9tPioOg7YT9L1XQYfi52Ht1z8WnYCLAPRhoWG8yhGhKMWZ4uGvNQ66JvZ1KH+iMEcNDC
	uMoJtMcgG34pYN3XelucMRuml7gSaSHHIgpTaC98JlRmqD8Y0+kOsv0I8sMGz8hNReEJ4ChfEsM
	I/5QkE5V/6dJbxv9miJ74T108xSQEuqUrXri
X-Received: by 2002:a05:690c:6605:b0:794:ecaf:c4b1 with SMTP id
 00721157ae682-7952aa925f8mr358513567b3.25.1770800426067; Wed, 11 Feb 2026
 01:00:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211075547.138904-1-dqfext@gmail.com> <67c6125f-99e9-4a58-ba18-8a2a93e29b54@app.fastmail.com>
In-Reply-To: <67c6125f-99e9-4a58-ba18-8a2a93e29b54@app.fastmail.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Wed, 11 Feb 2026 17:00:12 +0800
X-Gm-Features: AZwV_QggEoOmwIp1Hxw3pZYR1SDyWYgIv4kI9eixG9p8dPjtLneWmXqO7XNx6Fw
Message-ID: <CALW65ja3sumAh3uzD3W=n=3Rk0J7EDtcpbvdaG6+F2y2dFUp2Q@mail.gmail.com>
Subject: Re: [PATCH RFC net-next] pppoe: remove unused kernel-mode relay support
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-ppp@vger.kernel.org, rp-pppoe@lists.skoll.ca, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	James Chapman <jchapman@katalix.com>, Simon Horman <horms@kernel.org>, Netdev <netdev@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, Michal Ostrowski <mostrows@gmail.com>, 
	Dianne Skoll <dianne@skoll.ca>, Paul Mackerras <paulus@ozlabs.org>, Jaco Kroon <jaco@uls.co.za>, 
	James Carlson <carlsonj@workingcode.com>, Guillaume Nault <gnault@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258224-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.skoll.ca,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,katalix.com,gmail.com,skoll.ca,ozlabs.org,uls.co.za,workingcode.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[arnd.arndb.de:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AE5E3122814
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 4:41=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> This will lose all compat ioctl support, not just the emulation for
> PPPOEIOCSFWD.

So I should only remove the if condition while keeping the
.compat_ioctl, is that correct?

>
>       Arnd

