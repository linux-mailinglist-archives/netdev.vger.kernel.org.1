Return-Path: <netdev+bounces-301780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oL4pNRlRPGpJmggAu9opvQ
	(envelope-from <netdev+bounces-301780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:50:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE446C19A7
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:50:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jnCd1Qa5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301780-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301780-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 383F93020841
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D82C265CDD;
	Wed, 24 Jun 2026 21:47:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D461A5B8C
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 21:47:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337677; cv=pass; b=QAR9vnY1AL1dz3hUtxC/TTjggHXp7IpRUMncy1/dgDuFcEJfMA36WCqifTmujcNqa0MKsPywyv5Hefq0/1QMGWc78YMIIBjPfnD3fnEiHl6F8mou9M1NAve5x5gOme/61kN74/4MjKak/HeDr40gCPj3sIXiDOHXi/S6qpNrPtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337677; c=relaxed/simple;
	bh=hkFwlfmlGq5uiQhhguJIpFE+BzPicxluPWYKlmAeNw8=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOb3aVcD2jcWLEn1FSnrzKRy6qpXyf5O4J+9BmS8KJeboH+Z2pvyhcok8Tjr7GFXA/0zBMSSNHEy7QjLQTfA89YhUoKzsZThPdoMUM8qw5b062UrHrcu0Dh17vxSGf6AmDveZFV2OY5kA6z/ducJO0ieOHjXoDvCPylDiWOqmBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnCd1Qa5; arc=pass smtp.client-ip=209.85.128.176
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8051ad12d23so15314847b3.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 14:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782337675; cv=none;
        d=google.com; s=arc-20240605;
        b=akbXFWn42apySvmnNlq1V9fsgyS+RQDtjAoC5kW1ld5VhKwDirNP2/LrbGn7dTZPab
         GgS0HsiPVqE/DEWhGDQqE/b6rcRpnlVOj7JvW1gJHZjEgVJ56gEa6BH8ceQTy1WGxiLK
         fW5aMbInvUSsnelODoHk5Ei0VP+1zbit2FRGaimYixZ1xwSoTARbZfrmPFm+fZC+bg/1
         HmL4t6AkiRDW+HoAySn/EGh9Pwuzou2yzmL1Zms5cJWt4QNL3UkxA9qylZ3mCNbvLbYU
         iN5rAWlY634urNQDauJs8uVrdS+BPv9PmThZYwo8/8WO3XC6LxzWICGToKjv0GvxOcl7
         2JhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=hkFwlfmlGq5uiQhhguJIpFE+BzPicxluPWYKlmAeNw8=;
        fh=KaO/Alw2ALBWdgInflQuATKuNajw4I6oVa/4RFVt0ik=;
        b=gqAwEgPnRD/AcyCGNKGBMMfw9CXOiyJwFAwHmFyzXE6SaSrIVte295+IdhObZnywj7
         riTgCySqpuI46c5LyyIxqMPtJBR9RueK/O5kayiRJyt7oTcQBw9otg2MY4w1nzZduMG/
         AB6RKX9ed7Jh+/Xgf4lq7mMYiQa4BVuWEdSzqsGBhIWUJUpQzZd6fdhVYhD4asbqteJp
         RSBKcwnJN56glau4XI+gTDgKQZx33Qc5AuoXO3djLhnTHU5jzB6iGykOmoYu5pfHc1xY
         hzl8jkOhHiFADVXcthCAa711tfgI/mMBlGpGm0Iys+gqbDoWe1DVb5NAhmaFA+aDt3tH
         igWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782337675; x=1782942475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hkFwlfmlGq5uiQhhguJIpFE+BzPicxluPWYKlmAeNw8=;
        b=jnCd1Qa5U9pX1f6wh3ZWwbCacyNztSy7GGxq7n1htGWYI1K4CYLXRRU+jMJsYW9tZO
         BPRmkkgDieGH4dwLT/VLA0qS0v2utQ1pAp6RPn7cNQgSpOLFzIzVkB7mxicq3X7sr09n
         15hMBxQHuq4oKe5ZvjYi4NVM7Q2e1DKLc6zDOcdEfqsOSAXqLv1PT0eaVNpBJPKeENgf
         NLUkNGxObglxjF1aES0vCjDuX8FRFqlXQahrDtxcW2GpXmTH27xj5ecJx4LWv5h12sEJ
         FBtxc+tE1VjpeIRm26KE1fwUzaPFhKG/RAgrCVwLACDIco7mz0FV3RAKpr3ioFH9nMf6
         MXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782337675; x=1782942475;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkFwlfmlGq5uiQhhguJIpFE+BzPicxluPWYKlmAeNw8=;
        b=ENszkT/mhd1BhRsml1w9HPFwm0ZK/pNXsibtFV9jP0LkxcwTLnjyGgrvD+G7JLsNBz
         3OE/rc7ktv3wWQrDeUeW25k7PF2kr5+IOyxrN7DXgFp8g+fyEwHxHfE3GNKO0p9BJA6A
         1Qvt2FvWBRVK5xw8vPQ7XklW9oIu8P1QuU5O39auZbF+KrfG2Ec/uLT3LerYbt87TY+z
         zym7X9jv3cgDIG9MwUH8y5oeUaAB2HfRxTcjaMxz/bACG0Tf3pQhxkTupOjed3oBWC1Y
         cIASD4kcIKDd35ngdB33BbNZiDtR9BWsjkBLOGCGEUny2nBd2c25hafDjHJdpi3lsA8N
         mirg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8+t61bccUqyTqZdmW9lp7aNDeEplOIrYu+BsJEBqnZAR07ywuAROkFuvprBwLxtww35TDwME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxACSDJnQ2uu3eNrCqtbm074iVA0atB8rPRkPGMlf6iHiOScVoA
	LdFBwqpxZavoqVu9w1hTffStG7tjNQlqQ4BxEiXSRkIo8tvZ5FJPRmCfrthCkkqGfWfF3lruN7x
	aOpSYVaqJOZRZspMvsZ9izq2mUcfdLYE=
X-Gm-Gg: AfdE7cmW2mXIl63VE228nIfnF5+zrKie7i38p98LE1YcxWP78bXvc6ZlgmqZo348hpV
	yTXJum4tvo4vi0Ubl+svF3J/BxYVpbXjRGohV+8cLP05fN5yWgoehMbj+WHRPkg7sza8qOZ+9u/
	YAW3AVSKPSz8yzgumnG5+qO7WsNeksRJDvFKCS2ZWIA+G1RU4tEy2mt1AdCP7lj0ftit6PP0bJ5
	0YKIT2q4NpP6mKAv3lXdA0bv/Iux+pomE59iNeRI2M8jBav47W8AY94G6jIyBsaVPe7QmVZ
X-Received: by 2002:a05:690c:628a:b0:7cf:d242:d966 with SMTP id
 00721157ae682-80a63f4560bmr669177b3.15.1782337674985; Wed, 24 Jun 2026
 14:47:54 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:47:53 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:47:53 -0700
In-Reply-To: <20260624153850-mutt-send-email-mst@kernel.org>
References: <20260624190653.2893-1-alhouseenyousef@gmail.com> <20260624153850-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Wed, 24 Jun 2026 14:47:53 -0700
X-Gm-Features: AVVi8CeynxX2_AcSDWHorX_h258yRsucuQ_SkLNN6wE5TmhSJnB8IHSA5IRr3Og
Message-ID: <CAMuQ4bWKsMA_88Qt-0azvUckrKkcY87i0PZFmJ9Lozo-OsXtrw@mail.gmail.com>
Subject: Re: [PATCH] vhost/vdpa: reject overflowing PA map page counts
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301780-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:jasowang@redhat.com,m:eperezma@redhat.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EE446C19A7

On Wed, Jun 24, 2026 at 01:53:38PM -0400, Michael S. Tsirkin wrote:
> You should add "on 32 bit systems" - I do not see how it can
> overflow on 64 bit.

Right, the overflow I was trying to cover is the unsigned long
page-count calculation on 32-bit systems, where size can be wider than
unsigned long and the page offset is added before PFN_UP(). I should
have made that scope explicit in the changelog.

> I don't see how this can happen at all - pinned_vm is in units of pages.

Agreed, that part is not needed for this fix. I'll drop the memlock
check change and send a v2 with the changelog clarified to say this is
for 32-bit systems.

Thanks,
Yousef


On Wed, 24 Jun 2026 15:53:38 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Jun 24, 2026 at 09:06:53PM +0200, Yousef Alhouseen wrote:
> > vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
> > size before computing the number of pages to pin. If that addition wraps,
> > the code can pin and map fewer pages than the requested IOTLB range.
> >
> > Reject sizes that overflow the page-count calculation.
>
> You should add "on 32 bit systems" - I do not see how it can
> overflow on 64 bit.
>
> > Also make the
> > memlock check subtraction-based so a large page count cannot wrap the
> > pinned page total.
>
> I don't see how this can happen at all - pinned_vm is in units of pages.
>
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > drivers/vhost/vdpa.c | 12 ++++++++++--
> > 1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index ac55275fa..090cb8693 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -1102,6 +1102,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
> > unsigned int gup_flags = FOLL_LONGTERM;
> > unsigned long npages, cur_base, map_pfn, last_pfn = 0;
> > unsigned long lock_limit, sz2pin, nchunks, i;
> > + unsigned long page_offset;
> > + u64 pinned_vm;
> > u64 start = iova;
> > long pinned;
> > int ret = 0;
> > @@ -1114,7 +1116,12 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
> > if (perm & VHOST_ACCESS_WO)
> > gup_flags |= FOLL_WRITE;
> >
> > - npages = PFN_UP(size + (iova & ~PAGE_MASK));
> > + page_offset = iova & ~PAGE_MASK;
> > + if (size > ULONG_MAX - page_offset) {
> > + ret = -EINVAL;
> > + goto free;
> > + }
> > + npages = PFN_UP(size + page_offset);
> > if (!npages) {
> > ret = -EINVAL;
> > goto free;
> > @@ -1123,7 +1130,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
> > mmap_read_lock(dev->mm);
> >
> > lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> > - if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> > + pinned_vm = atomic64_read(&dev->mm->pinned_vm);
> > + if (npages > lock_limit || pinned_vm > lock_limit - npages) {
> > ret = -ENOMEM;
> > goto unlock;
> > }
> > --
> > 2.54.0

