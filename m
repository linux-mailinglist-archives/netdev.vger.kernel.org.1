Return-Path: <netdev+bounces-280280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDKKKjIY6GnWEwIAu9opvQ
	(envelope-from <netdev+bounces-280280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 02:37:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 133BC440E34
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 02:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C0DE303308D
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58436175A79;
	Wed, 22 Apr 2026 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="h0NJU/xW"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9024A23;
	Wed, 22 Apr 2026 00:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776818223; cv=none; b=iqXaLxHaSopjYWfUfPFRZlgl4LdRfpU1Jaj2jFwO53Lemf0qR7vtCuAAtGcC2FDbvibrxPYX/nIwyWHF+YIsxeAyKBOo6wUX7gWn+WvJpcV8+EX9JEo+xkWaCeLhgHSgAnDOCO+m0xUmWPFpKZcPIt/OLNbgwb6yh0D7jF47jdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776818223; c=relaxed/simple;
	bh=bO3NOqwjsP7MiNelqR1hAg21aYupK9Fe2FX9plbCZvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaDztsrVnPWUiO2tf8ZQ6l17g565yx5ALsZCayEUqbNjEZVWuTJWEjlFwxBVQMdskalPFx492XMqpd0PwD84l6XRV/9bbt6cuVaEVzJAjd3fRkAN9sJn/kf/+kojXABUyUrrjDJsoG1ug642/I7PtnA6LM2ORo5vQxIEp1tTqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=h0NJU/xW; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (232.154.13.160.dy.iij4u.or.jp [160.13.154.232])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63M0aplb086551
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 22 Apr 2026 09:36:53 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=YBx+MIOtWAPaDsDfwt6FFgYvmTmWT34dA7qBErfIMtQ=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1776818213; v=1;
        b=h0NJU/xWnne6XeoII10r0TgHw9cSH0tlMzn967avU1ed4OTjNCHfBTJ/75/axyo9
         H309BFOIPxzoEPPL1e+J1whlBMRNPpBC4XTvxl5Ri3HkRDpU4PptdD4kRWpG3eYc
         QsrbqlOCAu9yW2bcdolh3kZ4lcwYX3V9wVDlkWVu3nII10lst8iVjmeKMHTRQzHz
         5bNUthFdkaEUN/tVwXiDR3HuASXFBS6j5B8BSJ2y0KvkFnKfbJa2p0m4VtREPfXV
         wVrNWV28gCS0OGXbt4id05EK//OjRPHi8Qrzvjo0/+IZqGvbelMJBn4EIOIQbcYk
         riazpdpwepkAoq4N4+fxQQ==
Date: Wed, 22 Apr 2026 09:36:51 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: syzbot <syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com>,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kvm?] [net?] [virt?] BUG: sleeping function called
 from invalid context in vhost_get_avail_idx
Message-ID: <aegXjsir7lWLc0pI@x1>
References: <69e6a414.050a0220.24bfd3.002d.GAE@google.com>
 <aeerTzpq8B-WTKeC@x1>
 <20260421165358-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260421165358-mutt-send-email-mst@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280280-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:dkim];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,6985cb8e543ea90ba8ee];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 133BC440E34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/21 16:54, Michael S. Tsirkin wrote:
> > 
> > #syz test
> > 
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index 80965181920c..c6536cad9c4f 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -560,7 +560,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
> >         busyloop_timeout = poll_rx ? rvq->busyloop_timeout:
> >                                      tvq->busyloop_timeout;
> > 
> > -       preempt_disable();
> > +       migrate_disable();
> >         endtime = busy_clock() + busyloop_timeout;
> > 
> >         while (vhost_can_busy_poll(endtime)) {
> > @@ -577,7 +577,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
> >                 cpu_relax();
> >         }
> > 
> > -       preempt_enable();
> > +       migrate_enable();
> > 
> >         if (poll_rx || sock_has_rx_data(sock))
> >                 vhost_net_busy_poll_try_queue(net, vq);
> 
> 
> 
> Makes sense but this stipped up the bot. Try again?

Hi Michael,

Thanks for taking a look.
I've retried the testing, and it looks good.
https://lore.kernel.org/all/69e8119f.a00a0220.17a17.001e.GAE@google.com/

Will send an official patch.

