Return-Path: <netdev+bounces-284896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFQ/FXhb+2mUaAMAu9opvQ
	(envelope-from <netdev+bounces-284896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:17:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AEB4DCFEE
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8D583020EBB
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300E03EF65E;
	Wed,  6 May 2026 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtCDUf9k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPnfHl3W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A70727EC7C
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080536; cv=none; b=e4aO20FUf0l0eQR1BlvjG0e6XrkihwgMb6iasJ2LFJ6UrPEAi0wHO3KJ0Fi+hUCKppsyWygwhOBIPWurYq0i3ge2Y4A5K/057ueKzXaMKnzFESs7Gj0w+gn0BnzEpbQvcgJzusjN14mMjxgQ8pEfEZGQV9IWh47vGhWm8n1Mdns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080536; c=relaxed/simple;
	bh=dyYVoDEtFDSgPhQADtst+OcAghGp7Ei9IraYcw4HcQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/LuF1F2DrivJ0CjbL2nrNLLyuiuAG5cYjyqu3SRmgT5viukSbbqgasU+rzpxlcunZIe6ip38Nwu3/hFJW0bPWlgT7258cIpzM9ul6utsopfU1JX5evchH6Osq90lyNff/CLhQpUhdXkp3I08DTeb8imprxt6Qy1UfS8ZrVEtq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NtCDUf9k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPnfHl3W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778080532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dyYVoDEtFDSgPhQADtst+OcAghGp7Ei9IraYcw4HcQY=;
	b=NtCDUf9kewHCtvEjaEvqXAlehx46BN9htd9G4G46GR3Wfko+84pHxmg8xfRUkWDnSLB5ck
	d/8TQYgRxGdBvQcR4Hbzhjd+CO+Ut+e6cX2SBAv79r3EgnXoKW/+wbjS6jZeYqU8/vGZ2j
	IR+vdbTlnI/h+Bp7gRXnvr+VHG7MlxU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516--cR3YbvjN0qBdXzYupvYQA-1; Wed, 06 May 2026 11:15:30 -0400
X-MC-Unique: -cR3YbvjN0qBdXzYupvYQA-1
X-Mimecast-MFC-AGG-ID: -cR3YbvjN0qBdXzYupvYQA_1778080529
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48e526e11ccso7414095e9.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778080529; x=1778685329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyYVoDEtFDSgPhQADtst+OcAghGp7Ei9IraYcw4HcQY=;
        b=HPnfHl3WhXiNQLzmBF7kK7Jt65U184IqyoxE0M484yInTICyzYZGjvoFtNgfrA/vxb
         LgKndyUbhjOmyVGOYPU9wnbkMXnlkiFeCOhtA8DVSP1OfQEcteB65H7weMmbPLYHXSZz
         tqoncI/gvvSSrcHK7V+mdiEZ0MQfF5IVo0s1YqBB5yQqoSTzz4DXglfskPmm5aofCJZK
         1f/heqbeljqqjzI7rweXi0nRzCqlhVS+uj7jHcVU2MnkAjRIXa2x8cniN5dKHKc+gYin
         qxxGcIPkYwE12TpvP8eI3+2vYp2/v+68XzZGXa4agzNfuct1ohrRSCnaY5XgkSAKnmvM
         nF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778080529; x=1778685329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyYVoDEtFDSgPhQADtst+OcAghGp7Ei9IraYcw4HcQY=;
        b=VuMek2Z+6p/RTY64sALczU8cMoy5PLCQnMkOXuoE2AdyoWLVAH9Y+Se0X06d1yb0ek
         wTp9FX0Fcl8pId1aBPkDJ1T78F6ko0WUXsmi6s/G9/W8p0y/akQ+0Pk6cDgcs2lvNC41
         OnmCtfmxgbbQNxssXDYTXytkni2+8adRoOlWRNWzC+D9cP0I7czg/hK84qESDWG5lrrE
         FDRM1R4XkgriDpEIHVIzxuE1b1E/EJg1/X5ZVi0zAvId+Aty2K8pPZ0Bz4j848sA1x56
         USTn1XQurU199bjgPdvWquXz5WrDtzUop0Q4uo1JbltTHTtdkwN8duNkcsPQMos6oY/i
         ny8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8TIqRyQRZkB7f01rld2Y2HHQUGHIzWWspo42VdMbTjyccoq0yNSqU87UpZkdzWT/RdZkTjxZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKYk5eNlKgwtH9z/tk2oJQX8EP/LivFI2vsd6BkMr2IIRIcKJ
	Pl9KjXnMF6ktZEwUQ3L3vt0vhkZTrIAbSPIY6j4pq+Y3Y3d3TXHPOlfPxUsw+6I1bca05XVCBWO
	VoM/M9YwcHb6LTYOc+vFLTSM+T9itmG0DodpBiiOu/FJMWaiV22nAjRpqrA==
X-Gm-Gg: AeBDieuWsSIdr/N1WUeTyLjwVZ7vb2d8hKwxsuJv8K4LqVoWHbAW5KBFQdB2LwctRTg
	R1H5uxibmUEzdlscU03Tmsi8dfepXyz1RyieJOz7As/8bHkxUdWG1MpO5YFRu7aVQzEvuE4AfDG
	+XIi+M7aPYMd2tBQWP3eE5mZSoxmZvxn3yGYVzVmyoC/3nbNRKOb5XGEPOVxamVXY7gR5Nx2PJ9
	dIhzrIC/IppPvfP3FfroGlvAwQUTsC1Y8x0fSDpzhgmEXdF58UAPkAKsKrM9IKrjRlfqOJanSkK
	GM2l4MdfEKYa/JpJoBWJoP7gYp6nwACnwttMJrV4ytqpbM8R1mQW9SUHzm3uKXNsSxv6u5IiT8o
	nce5WxRLh/HmfrUngyO3WqjQdWXSTCFPTXHzIA8yX0nvyy4uwLac=
X-Received: by 2002:a05:600c:871b:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48e51f45eddmr62856805e9.17.1778080529280;
        Wed, 06 May 2026 08:15:29 -0700 (PDT)
X-Received: by 2002:a05:600c:871b:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48e51f45eddmr62855865e9.17.1778080528659;
        Wed, 06 May 2026 08:15:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538b26a3sm95210515e9.9.2026.05.06.08.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:15:28 -0700 (PDT)
Date: Wed, 6 May 2026 11:15:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <20260506111507-mutt-send-email-mst@kernel.org>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
X-Rspamd-Queue-Id: C0AEB4DCFEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284896-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> There is always a discrepancy between skb->len and skb->truesize.
> You will not be able to announce a 1MB window, and accept one milliion
> skb of 1-byte each.

We can if we copy.

> This kind of contract is broken.


