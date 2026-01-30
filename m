Return-Path: <netdev+bounces-255216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM7wAlPwfGndPQIAu9opvQ
	(envelope-from <netdev+bounces-255216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:54:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A8DBD84C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 172EA3033A98
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8654E364054;
	Fri, 30 Jan 2026 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="lvqXB7nL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7CF330658
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795633; cv=pass; b=IZlkS3m631aeGpaUNGbKU5OZ6bwZiK2E0ON5JXiSpesw/axorgVroP/0pck6/TuVChV/x9zHQSmlzdSiAFSLrK0iwyEzVhuzbem1znE4SkBcu+x6MLET5GxL5D3512q93KvUkV+xeg/tINYcJo5ySwhLAL2mdJYfoPoIopyGzWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795633; c=relaxed/simple;
	bh=326he210/tRZUiUmp5+sWT8etWqVRtLzZLG9pPxkOqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FavnL6jPohtO1w1uRbjcZ45H1ZfgnzMfnydMGATfjsPACLFIe/PQdHvM8N/Ob/bBQ7sEQn3KvXr66VQIkduVV12ywvpmhI7XBx9zoBFgc61cGdZoOQI8zaWbSsiE94Lq5gkqY+x/Wv8FkgfGzDtYFXLraKZPSmwsCTA4o/qedEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=lvqXB7nL; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f47610542so1387765b3a.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 09:53:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769795631; cv=none;
        d=google.com; s=arc-20240605;
        b=PbxSAt/LjR8cakL7pk3k+YKxZtWEFAOxGDSpJ9YC5pBIiAWj22toSZTgAapqj+dXow
         YPYsosdHQsbYZi1fPJ1vy2lHlX++mAphRXMUeYfwGXrIaDD4PeTDDTqwbWE47BCvRe3N
         Sy/mYGYVLjEBfM3yDeLUUyrcJvhGY0jL0WleqeDI8Du1+NggsxBJsjr8UT4322xFfxbQ
         ORPG+rYScmVjzDd5/eude1yc+2mu0eNPxUj+Qxk3Ni8hOYS/+e9XgiCIzygwiQCmWlDk
         4tgQ4uIdJKfWUCvSHLEM77wktnnVIiEWusUbrmGj4AmJSgMm/mhE8cUB4C36aYoVRjnm
         kLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2vQAO1Uv8zYyW2LQO1EawZkOK3KNj111fQmdKtqn2pc=;
        fh=d825hyJZgoaUkZ3eAKRyzjfAo2sQ1Dz7vSNc2ZZXL9c=;
        b=BbdMwJhk1yG+bq06vwrd0Ya2wqD+CHo1B08w/wqnmoCQRLp47hyteRBSnIlYkMlUgQ
         hI+w3Gk4aqQBU6GAuvRt2kQYVy3rS2/Vmu6HhOPFMD4t2bZkX3LZ78yokOx7ph5P1Ozl
         TdkqkmefgTt0tYHKUXROPbOQuLe7zrSkNHVK0VdS4ZAVoZDXqF4yU7lETBUMEEke0sv+
         mh6Eq7LOqYx+U8Z2Qc430IleGuRVEdGSDMe1+bmT4YlROJvIUaNiBx4/ooNCrnjEm/V2
         5TEo8mVO7g7NcMb6bzfkYO9SZrQLfmcfNl+ngEAsq4OCoQVRUil8M65xc8EYv8EPyKMa
         c07w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769795631; x=1770400431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vQAO1Uv8zYyW2LQO1EawZkOK3KNj111fQmdKtqn2pc=;
        b=lvqXB7nLsiR+cO4h+FLw1npQHKOEDqLC85zIfdXSWxy6Ae9x8QnfmhSBuEyAkhphHW
         JW7eE/AMSZZ1Ub80WcnCPonHfvlsNi2wg5/vuOD893X/twFxOroJvFxARweAcTfGUQtk
         HqE/PupgfPkxIOvLl0KWHyApCP6SaKrla9qhnxzTBDzSjHbnkwYBKnYXNGnZHGmaYpfI
         J2Yds9tsH+4ZrLOKzapjjJfTdEPAJoA6rKuJ9vqu6l4XWY2rWGQERDs9SP6StOzowJRD
         7FjQYz4wgFNnlH3pkHKYdAPp2tX1ioW/lqrVg6oTCdX/vn/keQBnWLixi9qaPawJn7Xu
         LJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769795631; x=1770400431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2vQAO1Uv8zYyW2LQO1EawZkOK3KNj111fQmdKtqn2pc=;
        b=Z4sFINpvY5x4eim924mIxtGmAm5YM6HlMFELKyfvBi3Ef5LZjfLzVoG9oAsv+to2L9
         T9/0UmT2bSsyj7XI8Yqmfhs/aG9osJTv23tSQWqyfyN5fL/ghDvdB96r78kasNH/rVo9
         imyKi0NmnRAPSH2BAEutzLsGzSj1PBb7G4sPmoaFtFQXm1Kxf2CqVsao6SR08dZIen2x
         FTQ3QRknHUjcCN1hk0ki/G6LD7cr/QzzqR3kp4fJf2wZ9uOWOq0t8vHjgqY6Uttb2nzs
         sYYIlyDf1HsQ5p45m3TUN0QydzR9WY5v/RdrVBl8Ow7qJTD/aQ/GNcgmhF9tO2F4eZnS
         +V7A==
X-Gm-Message-State: AOJu0YxMwuj7DLUn5wOeZ5e7q1TRh5fPaCtKBPh7dEP9ez+yPkKbJ9oh
	YsTqdyuyCRj3xfS2OYExSuJjtNSsrWZe8X5Oqqyb+VrYpWW7rIv6ZyIuZcZGgU4Hr/ATaaVpqyY
	8ITrOt4iwVPrdbakPrHnBttw2zVd9BcVeYjwSeQln
X-Gm-Gg: AZuq6aJSBpAU5CWxs45o40qnIX9CuZnbBLnFXUMeYHL+MmW6nAsSWgNEga+/a0hMDCh
	cvaHq6adCgRDyMH7ZYUMFO9zVJu9MGbjkFERvsyV11BxTZEtJkbpzLQJZJHfN3/fsxup7nB5el4
	+T7Jz9jUR6zOACYQfhNzCjWkzWh5KIbuNONoK2/0G0Bd5JymTLuzl9FfPBQbXJyzkWCntckd1UW
	nYPZAWl8d8xq8x+vlA0Jh101LbhAcTXwhJ2gq4U+VK3Sg0+SAyPJBHjmn977YT4Xewm27Qe+4fW
	4K/8fLqwCWvLhw==
X-Received: by 2002:a05:6300:6141:b0:38e:91a7:6352 with SMTP id
 adf61e73a8af0-392e0163b8dmr3106804637.66.1769795631321; Fri, 30 Jan 2026
 09:53:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130134220.305757-1-p@1g4.org> <CAM0EoMkS2Uoarr+551wNe7zvmPTGFZxdb-otKYLBPF5+2s+FEg@mail.gmail.com>
 <Fkv_0Ju_R82Hh-rBUDW7uALCp8vjL8WZqAsQhreDrulXNad2A2PlNWkSO-95bSzYNai0wYDsZZZFtC2-YAr-B9ZWWtNg8iqafAMDUA0F7Pc=@1g4.org>
In-Reply-To: <Fkv_0Ju_R82Hh-rBUDW7uALCp8vjL8WZqAsQhreDrulXNad2A2PlNWkSO-95bSzYNai0wYDsZZZFtC2-YAr-B9ZWWtNg8iqafAMDUA0F7Pc=@1g4.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 30 Jan 2026 12:53:40 -0500
X-Gm-Features: AZwV_QiQhjrnk_kiCNTQ9hpPibGH8uv5bn2JIzi1spPEoRMYIYMFhv-zfwvpGj0
Message-ID: <CAM0EoMmY-v0HWAkB5EgSYhpca8fXVX7SQ1SpVbUBcFpbvuTd1g@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255216-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,1g4.org:email,mail.gmail.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim,raw.githubusercontent.com:url]
X-Rspamd-Queue-Id: 28A8DBD84C
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 12:22=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> Yes, In net/sched/act_api.c the GETACTION notify path always does alloc_s=
kb(NLMSG_GOODSIZE), if tca_get_fill()
> runs out of tailroom it returns -1 and tcf_get_notify() maps that to -EIN=
VAL. So failures are size-dependent
> and can look intermittent across different action dumps. act_gate might b=
e the outlier?
>

Very bizarre that dump would fail because it is transactional. It
shouldnt matter that you are only allocing NLMSG_GOODSIZE.
Is there a possibility that  a single act_gate entry can be larger
than NLMSG_GOODSIZE?

> The size is already computed in tca_action_gd() (sum tcf_action_fill_size=
() then tcf_action_full_attrs_size())
> and add/del already allocate max(attr_size, NLMSG_GOODSIZE). This patch j=
ust makes GETACTION consistent with
> that.
>

I looked at act_gate dump and it is sane. Which leads to perhaps your
test program being bugy.

Install the 100 actions then use tc to count.
Something like:
 tc actions ls action gate | grep index | wc -l

cheers,
jamal

> On the reproducer: the gatebench test with 100 entries is reasonable.
> https://raw.githubusercontent.com/jopamo/gatebench/refs/heads/main/src/se=
lftests/test_large_dump.c
>
> I plan to follow this up with another patch for act_gate and believe they=
 both are integral to fully stabilize
> act_gate.
>
> Thanks
> Paul

