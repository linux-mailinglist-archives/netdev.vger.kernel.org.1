Return-Path: <netdev+bounces-278096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLBBM4/83Gk3YwkAu9opvQ
	(envelope-from <netdev+bounces-278096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:24:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 243CC3ED4BB
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4B613009B0F
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9333DA7D4;
	Mon, 13 Apr 2026 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnPpT8qb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0682A3D9DCD
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089866; cv=pass; b=lHlJA9+ZUdfq9qNhbuQxGQV33jIsWan4FHvGBJ8ZNEOfShnbFS+RNJyc5Zi4gxCpzgnaZv8bmalAbU35M8XhEu+/pMVA3SmfYzzvX93CbNlYciDXUy4ANX9p91IZcwtxClcZQ54+r8NWO6Ey/2NZs7OjJuRc/esGJQG+hbtjzi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089866; c=relaxed/simple;
	bh=XOWtyuKAL6gknkEFXx55R8cXf6NZ6Z0A/mZTOk+MOIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCnDKqXcJoMiDtHEafRurdcaMTwFrdKCVfKBlfXbo3lbXi9a5mnS2UmNAyjCVx8gbfpRb/bkl2rUcgWN1VFYful9CpSuV6s4wh6gySdB4zi/g5kefqd4najUNEu/kbNZs1+dJnbd12D4DM81swTkQGLiWXirjulnG8dNnnOo/MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnPpT8qb; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-651b2f46720so1350001d50.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776089864; cv=none;
        d=google.com; s=arc-20240605;
        b=Lb5fY6JkoUmtq8FBUhNj9v2cChGKlcfdOO5R2aVRZeYtwzmQQyawX897ZxCt+B1Fjz
         h75WRM+P5rt2jxxgYx0KyxtLS3uUEkhytTlgqQm6w+dEX4g/apRzPtCX2ro6M80sPN+q
         FHeqLIwsAWfj23+7D0BSbHIBIapB0/qT2yH16gqFdtsfEnWUCATOv5d6hw0M1KQt+X3v
         VDf7UQoojzUKTEIAPnKInrl2RresWniw3joy+vyiBcRxGR0IkuWbq7w+jzGkHOzcCYdX
         q/EDMouZGhH/+14UJBfxXkxIXCwclPFWhIHbmLgyVi/dlQLqNKCxrJOA5tzDklT/2YaJ
         cMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HO1lkDQOSwGSvR/focNvY3aOrH3YoM0fafS2AdZgUTY=;
        fh=iIu0rk+8Kcm87kKtDCu+wgrWxSBfZPMqbfZ7lsA0Fes=;
        b=RwEduhawYXusxmjBX/kBrw4Y06TQKGHSngtN4TfMCi3fUFuYqZ6RvZ+hybHJo6a/G7
         dfrm/Sx7m/Yp83JXffdGkskZEXjxbCXwSrsTadTrSJ09O+aZe6E/Q24/IQXHIGT+W89C
         kYDRsnoVk/Djd7jsrwonSEXXO9fk7c10IGMzYPv4HtQQx9ElvX92GpcYx6qLGj/NWdBT
         DO03wxAPxz7zfrc9Ra7pxyGqu6SrGlGckbaSxDDLN2VwV82MZAj7wT3egFC0SlyMjy5M
         oES6m8Z3/FvOqLCOpQHHez/boqlGI+bFzcD4M/JxBpuFsV8/zmnbZd9PlLGeuPzwC72v
         nlfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776089864; x=1776694664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO1lkDQOSwGSvR/focNvY3aOrH3YoM0fafS2AdZgUTY=;
        b=HnPpT8qbHyhPDmN/dPHIXaGDlDeib59kq8iKanjNpICG3aVDGseKl9FxktAuRTrNC6
         BUCxVOZ5x7KZvzPtVLlOC1eebuSXAs/FfwjW4XGr3BoKAY3hUgqRlW/CnGcXc2hOumYU
         yAQygbevdsDGeHRYS3V8tu5ai3Sq+i6BjAesQwe9emIZaXS8/zhxNuDI6wScfjkFzh6j
         8YIskihrkNtCt4FlbFYwoNvQAJboqZgryFOBl9p0plOZwZ5absjUBO+H5N7FnVRbhjfe
         Zl1atzNIlWjxgGhAjk7/sHqgJnlF3uCCXrkznzyHiEaaR9WjncS20l4QodsbUXnhG8Rt
         OrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776089864; x=1776694664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HO1lkDQOSwGSvR/focNvY3aOrH3YoM0fafS2AdZgUTY=;
        b=N1EjbhgTvf4dYgf6XSuPDnNiz08wIL+mv9of/nsvmFRoLxwUcRCM0nAWeCoRDF25Ct
         0qfQVwYTQyqPbyKc4z9pgWtdgyqRtDlD9tAAGQ3WjdYqpy+GoiwDqvIzAG2QpcRZreUP
         0rdras1QP2fj+HywPVc+XekYbFxzpAcNywa+aTn4c8kNKmJaQxWNxghsA+btsvPGwZi0
         IxBcW00CRlSuc9Amsm+z2nsgthfJnCE+jiADa4JqMdvSwwKMGBe04v+sONoGlZm3glEm
         qHfse5Z0uAc5OAAw3hSYFATV3lC8SqzVmc43gq9JritD0oMxQrzam26Vi//cU2XBAc3g
         umOA==
X-Forwarded-Encrypted: i=1; AFNElJ+g/qL5E8SiU1Wz3CF4WVx0rw20Ws10/ZCssdch1fKDFWonMfbHgAJkysdSn3lXz1JdmnNKBA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxST53fsCLXyfEq5Fo7edCV/Xq9magPaP2lCsbxEirD9N9qzJkb
	o1YkefrruICLR77BLmv8r88+s7yAqq2KlbsgU98YCP03slNm4X5L5DnIZlyLrfDRrTnj4goVOnI
	mcVhfpC7JlyKPQuQvHG9+dolUqb1UnP0=
X-Gm-Gg: AeBDieslSt6BtZuOENHKw6QHC6eyhax4Yv6De1A56r+naS+Thd8JNtQZfT8iDw2v7ph
	C6FNVc2Oytu9Efw9IvLnrZA5TsQbQSCn8aJ05s2gRdEmU+L4KcbFcihpmGydfVqY7jAjBAxTXvq
	G9XgDItltOsTkBGDbjNHteJ6EnRVieX06QlkhqHZDVUnGUCkHGSl8aOCWL/Wy7qVB9ry9bTtdDq
	h+k2LjrKYTkIerO7aorl9d46WLkyQiYM2i0Pg4S+HYjKhZ0x5iD30rr/yvJ1DJ9evN6giYs00Sk
	t5uSbasyNZ93Bk8qEW+ThuqjujauB/0N44lWFR+atCq3c0yC01u9xN5HUZx0o2Ia7LqXMg==
X-Received: by 2002:a05:690e:12c4:b0:64e:a9a1:fdb9 with SMTP id
 956f58d0204a3-65198b56526mr12424704d50.34.1776089863932; Mon, 13 Apr 2026
 07:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413132247.320961-1-luiz.dentz@gmail.com> <580f7972-56d5-4968-9dcc-32adc31e0673@redhat.com>
 <CABBYNZK5mMbuzvjAquy49vSk0pLRnk_s8oqEut1se4DToURn9A@mail.gmail.com>
In-Reply-To: <CABBYNZK5mMbuzvjAquy49vSk0pLRnk_s8oqEut1se4DToURn9A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Apr 2026 10:17:32 -0400
X-Gm-Features: AQROBzDl9NV24zFCz_h_KMQw8MsSN5GmeKZTjLt0RmjZYHnqkefpAK2oyFhy9q4
Message-ID: <CABBYNZ+7zr1jQ7a-2p88zNqMdvn6MAB5NAZ7b4OW=P56DcMT5g@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth-next 2026-04-13
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278096-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 243CC3ED4BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Mon, Apr 13, 2026 at 10:11=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Paolo,
>
> On Mon, Apr 13, 2026 at 9:41=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 4/13/26 3:22 PM, Luiz Augusto von Dentz wrote:
> > > The following changes since commit 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe=
434ad7:
> > >
> > >   tools: ynl: tests: fix leading space on Makefile target (2026-04-09=
 20:41:40 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-n=
ext.git tags/for-net-next-2026-04-13
> > >
> > > for you to fetch changes up to c347ca17d62a32c25564fee0ca3a2a7bc2d5fd=
6f:
> > >
> > >   Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling =
(2026-04-13 09:19:42 -0400)
> > >
> > > ----------------------------------------------------------------
> > > bluetooth-next pull request for net-next:
> >
> > Net-next is closed for the merge window. I guess Jakub could still
> > consider merging this, but unless you want it very, very badly, I hope
> > it can just be postponed, as the PW queue is already long.
>
> This update includes quite a few new hardware supports. This is a
> resend because the last one was dropped due to an invalid 'Fixes' tag.
>
>  Btw, I don't know why the entire PR needs to be dropped if only a few
> items have invalid tags? Can't we just dropped those?

Maybe Im doing something wrong in my side, the issue with the Fixes
that is that sometimes they become invalid once I rebase on top of
net-next, which, afaik, is necessary to detect already applied
patches. Or is rebasing is not really necessary and should only be
done once when rc1 is tagged?

> > Thanks,
> >
> > /P
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

