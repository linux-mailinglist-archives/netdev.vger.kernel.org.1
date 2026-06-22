Return-Path: <netdev+bounces-301223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IxZvExLKOWobxgcAu9opvQ
	(envelope-from <netdev+bounces-301223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 01:49:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA5E6B2DBF
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 01:49:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Oq0kY0RO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301223-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301223-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F404A3012DB0
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 23:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A43D371898;
	Mon, 22 Jun 2026 23:49:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F47C36607D
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 23:49:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782172168; cv=pass; b=P32dMw83vlcFhn/8G05ruNBiYkCQ4t247Y/yjplHVuR2l4cqM000KBK7K+UK8Zm8SE9KA7BvvzugRzHsoYf2m7bHDy2cEmSKhxZCu/bQs0No7h62+OQyhnu/4lOU7vI7n7GC/g/hQhYQtXgR7agrk7VvfSKbbWFm+Bj6m5o7AHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782172168; c=relaxed/simple;
	bh=adOwapYg7+gUvRoqCaWAFG19xXjx0M8sahK39VTKig8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxhelkXrtFO6hy4AwgQeS7ThO4D/n6xm/SLyO0SZqW3avahFAf/Bh7vUhP24k1keUsLeG+24dHuZCdrJwxyLv1enXZko6185WCfRSu1VWeD2tfFyUqAyM+MCbA5iiaDNCr9Ikjarkk8mHElbQY/3fCuQbxT5JMttilwamj5J5Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq0kY0RO; arc=pass smtp.client-ip=209.85.167.51
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5ad536cd0c6so5148937e87.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 16:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782172165; cv=none;
        d=google.com; s=arc-20240605;
        b=Tg8jv+SC8Ks7ilQjHpfcbKO3ALDHGCe/egeXlA+GZjUZCA3E/5hNcI7KmcfyqEjs86
         v5K+qimyHNtT44Kh8Xtu1+8zNugpx6jsV/QHEdNJjwG1aMKQgl/4uV4odfmVpmpuAM/5
         RoOlm2p+h329iNpka8qimhEUFPAQQuq9B5jg4rVgkFf3HryI6VjYrH7T9ijz+1j5aom0
         pylDDuMW9umuU5LGaJpWtaqTVyH9MUFTAw5rM1ATA9VjAXnbA3Rm87kEOjGS5WIjdTWU
         +IrZNC3nYmgFXnWXGV/EL83SO2yOQ2CckNmMuiVtAAvxjTDqQ7mOCKzAefubTycQXtKx
         cL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=adOwapYg7+gUvRoqCaWAFG19xXjx0M8sahK39VTKig8=;
        fh=tvhp7pn0PFTlAKjUc4WVhSvyAIwrP/ZYrddVnn1vkoM=;
        b=ghJ9qisAlH70uYtPeyQHxhoPhYd4/hr6sMpPqbZrs9bHyf5gbw2XvhP6OR6erAnPip
         IwjkZCA1lZclyE7vz28cwrSBUBKPAwQIALZ1/OYdADmits6jRBmS0B0UQNkxKV6jCAI+
         5JgGwcI7hY5j9jkd9PTvHEy+qJW12gZlu8zSIq1e8eYGUFH//DkehBJbAkVaWLDq65nY
         xf/RbSLHP2sz+ms4p1iTVSf6E8CuiQ5dQcCPmJT6mpZVXx9INL1ziaH+G0l6jCKjbWio
         23vt4ygDfy3YoM8YxoiLZY09Ah0SUXsMtavqnxhgQHZ0T6FNi2BeSFjrn+CMPOX3KUHz
         9qOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782172165; x=1782776965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adOwapYg7+gUvRoqCaWAFG19xXjx0M8sahK39VTKig8=;
        b=Oq0kY0RO4G97cxbgDy70N9M+XXG79BZ79rKm92zbZVP4N2IIBCvFv3dOM+NeamZbxR
         trOzVbu2IxOzTljNcSZAUga5zOhXk3d953r/UU/jjc8oUPymobr8ZqLNIBjncJ1VsUEu
         Kh7n0WHbuKx1yTBEseJNtuNmXJm9DstSiMGJIKrn4LJUFVA7ibB7zKJrCaQgmgLDnpBp
         dU8YU6x3UEQU67G1pXPgKJ0s/nRMMa/K87enlKnXJg/uFdOmAwOArn/v1L8zLusPQn3s
         mWJqEzVnY0fTLlcabNcUxhkhJZ703dcF55Rk+pkIrH9B1Vi5IHEt/wiG4YISpLTf7OdD
         u+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782172165; x=1782776965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=adOwapYg7+gUvRoqCaWAFG19xXjx0M8sahK39VTKig8=;
        b=tNws5eR+MK7cdOS1STjK1aCyVpJ+Mkw0fHlYcLjnZPH3fiJaWcF7TxgyyvSm56y2OW
         qfh5KhreST5GJ519JOrTr0Pm6a4w/eDjWcbrlpVHVpDPSJ5ByOcGTcjyPfhfI7v1NluO
         fa8HVTX47kyEYXGQqK+5mD/0XLJtgzHE+42mxgw7Xd9yXXAWTTKkx+Y8r+iKbBap4r20
         dHEA3BE4f/Ysr8DosAd/xcI6/FFbijIqW1yCg0sehK0T2lM05VucoQ9I2ZxOdPWo8+FP
         jv61TFYNN7kLwEb/vAcQiXl08MsPoBEvy4dZxkHPC7Tcjzns7TnqYo81QpVSs9GDmZLU
         1BGg==
X-Forwarded-Encrypted: i=1; AFNElJ/nG7BLIAYbgVWz87JjDCBs0koiahCLULZOVzcvBPdhvtZfSXyp+KMkLrWZoXvR39+On9iZcMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+YaCIJC6o2q+3KjHLKvv51bVLRgC3EcfBDmFgkJXaTE8sY62
	eqsJPrjYkv+rl1jfDMTfa5dceH+8gM7APJNccYZ/sLB/047+z01baDrBD7ixg1zz3asCVOCsE7l
	DhPpQJy9601zjCeIwOs0bol5MexsJdKg=
X-Gm-Gg: AfdE7cmBJY1SC8vhIjEfDQL5mzEPfgQFVUfV/+6JvMEMu1pyfZWZYN668DIHrIKgd2X
	WtP29xlhsG5GZ4+OfM18KgA/8/anS8MpDjwj0Nt6t7P6PT0vJybjWQaAro9ZpVnlI1UvENyVWX/
	1XaZPM5vMSrqah8uers9q/hXIcCsNYoPvIxa+jMH7SNoUI2Vy/i9DR/CCA+a5kJd9I1bRpk65G3
	6MgxjKhJPNs1fqQ2RjrQuNjiqLjcW2zwr8B/frITUKaBLA9e3tcLbSAIDMybCwqyqYwk01jxIyE
	6JXvYfWDmqtmwpe/VvaRS5kOzQL9kc4fSTPtGSFwu5HwRAjr//ddwekCOnjJjUkqkDbTPqqP4mK
	kkXvMjbtEsg==
X-Received: by 2002:a05:6512:8013:20b0:5aa:6e01:ff81 with SMTP id
 2adb3069b0e04-5ad5770aa4bmr3508733e87.24.1782172164873; Mon, 22 Jun 2026
 16:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
 <CAL+tcoDr0gtCPeGi1yOUtg+ZD2YxEbjAy41LBgG63b8-=CStcw@mail.gmail.com>
 <ajJsMj0QMOF5I8qq@boxer> <20260622160706.0b4a27bf@kernel.org>
In-Reply-To: <20260622160706.0b4a27bf@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Jun 2026 07:48:47 +0800
X-Gm-Features: AVVi8Cf3LHE0YZbwHl_tkTcu7hd3qcD9Ut_nkX72BhZiRl2XSMeVQBsWTJs5gTg
Message-ID: <CAL+tcoAQ4E0-zWH9tBnKjz8KLka-aBfnjMHpk3owM-B7ugjQ=w@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] selftests/xsk: stabilize timeout test behavior
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Tushar Vyavahare <tushar.vyavahare@intel.com>, netdev@vger.kernel.org, 
	magnus.karlsson@intel.com, stfomichev@gmail.com, kernelxing@tencent.com, 
	davem@davemloft.net, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	tirthendu.sarkar@intel.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301223-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:maciej.fijalkowski@intel.com,m:tushar.vyavahare@intel.com,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,tencent.com,davemloft.net,redhat.com,kernel.org,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FA5E6B2DBF

On Tue, Jun 23, 2026 at 7:07=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 17 Jun 2026 11:43:14 +0200 Maciej Fijalkowski wrote:
> > > On Tue, Jun 16, 2026 at 11:50=E2=80=AFPM Tushar Vyavahare
> > > <tushar.vyavahare@intel.com> wrote:
> > > >
> > > > This series improves AF_XDP selftests by making timeout handling
> > > > explicit and fixing sources of non-determinism in xsk timeout tests=
.
> > > >
> > > > Patch 1 introduces test_spec::poll_tmout and removes implicit
> > > > dependence on RX UMEM setup state for timeout behavior.
> > > >
> > > > Patch 2 fixes thread harness sequencing by attaching XDP programs
> > > > before worker startup, removing signal-based termination, and using
> > > > barrier synchronization only for dual-thread runs.
> > > >
> > > > Patch 3 restores shared_umem after POLL_TXQ_FULL so test-local
> > > > configuration does not leak into subsequent cases on shared-netdev
> > > > runs.
> > > >
> > > > Together these changes make timeout handling easier to follow and
> > > > improve selftest stability, especially on real NIC runs.
> > >
> > > net-next is closed, but in the meantime I'll review the series ASAP.
> > >
> > > BTW, another thing about selftests I had in my mind is that are you
> > > planning to work on this [1]?
> >
> > This one is on me. I took your changes Jason and aligned ZC batching si=
de
> > to this behavior, followed by xskxceiver adjustment. I am planning to s=
end
> > this today EOD, however let's see how badly internal Sashiko will kick =
my
> > ass.
>
> Hi Maciej, do you want these applied? If they help make the tests less
> flaky I think that it's fine to take them during the merge window.

I'm not Maciej, and my take on this overall looks fine to me. Sorry
for the delay (I've been too busy to review patches during this
period).

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

