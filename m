Return-Path: <netdev+bounces-287513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCXLA2RMBGrNGgIAu9opvQ
	(envelope-from <netdev+bounces-287513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:03:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5E8531149
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE60C3013848
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF92638A299;
	Wed, 13 May 2026 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVnq/GLj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLhqRy8y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F63890F7
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666593; cv=none; b=LudiBxsg1OUL8OsqFNIJObErRXbh17UFshsmRlIuJV8+bPBHlmgXSmoKJgTn56eiIGPkxM5YWYYjCt5s07bRhJ54+ZXuMt7IiDLfMrbe1anTpOiufi6KRXZS0ospldkXpbHaqz2liE6Xpq33hmOvhrbpaA88gunlWA7qoQc5Wxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666593; c=relaxed/simple;
	bh=Exx69UliEats+vm276UOMHgD4bfAdRTp7+mcrKpptDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDrjiw5Y7znOjJGt6VRS1G6+RpkoGvSm4Wqo8wU2ZUSfrQoZT439b146FfzL+1vsVuZAsh3UgqGB1up7whGYSgUUxrWBezTG4NoyyOhDxEnNfUBV9nQwjSD8RN6KF1jGE4/sfLNM7aqTqGQjwcnlJC5kvtRFuZ7yJRCp0/9oX3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVnq/GLj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLhqRy8y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778666591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xzQE32mx93ylvQsX4/nZCp5JUmWcvqaEWi0cOhGyU/Q=;
	b=AVnq/GLjO+v09um3NzOo9W+B33Mh0AG6r22WAz3RauDSh8Bs6GFIVGtTlP4vHLbyFXgAqI
	iPUrepqiF0cO7NTXBOdJpTd6tvKSy04RD4GqoI8//ZR5NLFFxfr84DytIUbgWlrRCl/xxz
	dSZHjONhdEdtmKnqtvo5AfdaSWyJnxU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-i856700LMq-gJNSMNKqxig-1; Wed, 13 May 2026 06:03:10 -0400
X-MC-Unique: i856700LMq-gJNSMNKqxig-1
X-Mimecast-MFC-AGG-ID: i856700LMq-gJNSMNKqxig_1778666589
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48906aa28cbso56009115e9.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778666588; x=1779271388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xzQE32mx93ylvQsX4/nZCp5JUmWcvqaEWi0cOhGyU/Q=;
        b=MLhqRy8yoI900fZzXwFq6bh8VD+hqdk8luL7JyJ7d64Bu8jfNT6dhUZ/yJAlbK0A87
         7Z4B/mW9dBH2u7p1xOEp0H8d+E9Q9FZCN4gtQY0YTFcB4z4gFyAH4Rd85KO33vVyy+Fm
         VZvfUCakYrtnmVMopO752vSL/ZiIw5dMsRIKsvSK0v3IsFilR6Blyg/p4fqJAZzhU7vd
         CJaLw9NfB9O3nuLgNlILpj2LNc3kKQXTVWuFf9HUNKXikBMNXUUBVJ+GG3zlDJ0vF7TS
         o2oVvaP0poscuwoRq5hAs8rr1H1WjcFdSghKsrcIy2vhaFeSOWKDNwiR+K4yy29Mh4kv
         VTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778666588; x=1779271388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzQE32mx93ylvQsX4/nZCp5JUmWcvqaEWi0cOhGyU/Q=;
        b=SeE59+1SWpZ7XzWI5kTksl3LWWy6XL/kY0nBcrnCvnNdOVSq1yWLNEabat7/YVFh/m
         bBB8h5qrhbVE6hrd5+u0oNOpNI8FvUMXTGxX1HJjghgDp0cTFxKtXwUWNBY0gJoY/LH/
         0AsOPo+QZe/w/vbhOPqu3XnBDddExNPHlxrNE9bV4gSQRj6YxS/Mase1llZCDMwwCKf8
         EwM8Ndn6QEbglhXc3O0Fi4D+xSID6Ef+EMlNv26r2nD1EkBGcTEKIQlAzBPmmlQR+mBl
         M64JQ9B4akPe7pQlg+8am2/8A9f9JCAMakjP0tLpsudgu4j+GBpVnV5hOTeFNEqJReLy
         /7Rw==
X-Forwarded-Encrypted: i=1; AFNElJ83cPacNryPXIRU8HpY6dgojOwbADX9QSeXF4F8wAwCnbCQ/2nymjTCgzGSxq3pFCy+EYZ1AnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx85JwvOos8ZzGleZ+fi+w+izHiFMH6Foc3wJre0YiOL2xENOna
	OaBXMtflmqpwlci9guXIVbB2P17gJWxyygBKPlEBMd+j+a5rtGBDXqKhAD/Q1HQIMWUIiH8bP0F
	jBK+t9K3OPVAyqPbdNXNkVXsj7f1i/UnnHxl2gJ5v5UflM/Wa9td1g5Sk0oBdvHGGsw==
X-Gm-Gg: Acq92OEG2znzDdcVuccXXSJM6nLhkEssxMwTwOrA78IUCkrjOiCS1gvO9iia8mCIk69
	hFGKRsvrPUBgaX69i7c1q75EF4id4OdDNW5FkxXY4ccY+u+Ru1Rue6LO87xZUlQa0UDLXl6wdJW
	eA4VR77drts5hjOFcjc+NKebDGAjcqn6y9Nv1nqdI7MYFsGqmW7VOSPTvjlAb5/MGRg6IINBE/4
	DFjki4+5Ltc4QXo6FkzMH8WNob+AtX/pIvv0V7vIavN+jlAPDstd/4DtEdIoubcZWlwvASgKl2H
	O1jpc8rfg/y6jmTFpfNJzsWw0/vpYE3rMwDZQdP+pejCArSHMQVRNBMqQWBIIA8bQJ/nuTcYFXW
	SaN869IfDloUBL/UvcBSUxLTj3cb6CDWpC9fDEz/F
X-Received: by 2002:a05:600c:4ed1:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48fc95a5989mr35259095e9.0.1778666588296;
        Wed, 13 May 2026 03:03:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed1:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48fc95a5989mr35258125e9.0.1778666587521;
        Wed, 13 May 2026 03:03:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3e174fsm59587075e9.3.2026.05.13.03.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:03:06 -0700 (PDT)
Date: Wed, 13 May 2026 06:03:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Polina Vishneva <polina.vishneva@virtuozzo.com>
Cc: "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"den@openvz.org" <den@openvz.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH] vhost/vsock: Refuse the connection immediately when
 guest isn't ready
Message-ID: <20260513060124-mutt-send-email-mst@kernel.org>
References: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
 <agH3WvJtAsQ_5zx4@sgarzare-redhat>
 <962b26d2d1daa9411fb71efab6af2c75d1c5f0d0.camel@virtuozzo.com>
 <agM8cxqUCJNjBDlm@sgarzare-redhat>
 <20260512120019-mutt-send-email-mst@kernel.org>
 <8ae7e443034026eda016322d22da52700e432f09.camel@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ae7e443034026eda016322d22da52700e432f09.camel@virtuozzo.com>
X-Rspamd-Queue-Id: 9D5E8531149
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287513-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,virtuozzo.com:email,openvz.org:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 09:44:49AM +0000, Polina Vishneva wrote:
> On Tue, 2026-05-12 at 12:02 -0400, Michael S. Tsirkin wrote:
> > On Tue, May 12, 2026 at 05:39:48PM +0200, Stefano Garzarella wrote:
> > > On Tue, May 12, 2026 at 02:32:14PM +0000, Polina Vishneva wrote:
> > > > On Mon, 2026-05-11 at 17:56 +0200, Stefano Garzarella wrote:
> > > > > On Mon, May 11, 2026 at 04:56:10PM +0200, Polina Vishneva wrote:
> > > > > > From: "Denis V. Lunev" <den@openvz.org>
> > > > > > 
> > > > > > When the host initiates an AF_VSOCK connect() to a guest that has not
> > > > > > yet loaded the virtio-vsock transport (i.e. still booting), the caller
> > > > > > blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT (2 seconds), because
> > > > > > vhost_transport_do_send_pkt() silently exits when
> > > > > > vhost_vq_get_backend(vq) returns NULL.
> > > > > 
> > > > > Can SO_VM_SOCKETS_CONNECT_TIMEOUT helps on this?
> > > > 
> > > > It can, but it might be difficult to find a correct timeout.
> > > > 
> > > > And, generally, there's no way to distinguish "the guest hasn't yet initialized
> > > > the vq" from "the guest is up and running, but didn't reply to connect() in
> > > > time". That's exactly what this patch is attempting to fix.
> > > 
> > > Okay, so please mention this in the commit message, I mean why
> > > SO_VM_SOCKETS_CONNECT_TIMEOUT can't really help.
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > If the guest doesn't start listening within this timeout, connect()
> > > > > > returns ETIMEDOUT.
> > > > > > 
> > > > > > This delay is usually pointless and it doesn't well align with our
> > > 
> > > I still don't understand why this is pointless. If an application wants to
> > > wait while sleeping, it can simply increase the timeout long enough to wait
> > > for the VM to start up and use a single `connect()` call, instead of
> > > continuing to try and wasting CPU cycles unnecessarily.
> > > 
> > > Hmm, or maybe not, because the driver will definitely be initialized before
> > > the application that wants to listen on that port, so it will respond that
> > > no one is listening, and the `connect()` call will fail with an `ECONNRESET`
> > > error in any case. Right?
> > > 
> > > If it is the case, is the following line in the commit description correct?
> > > 
> > >     If the guest doesn't start listening within this timeout, connect()
> > >     returns ETIMEDOUT.
> > > 
> > > I mean, also if the application starts to listen within the timeout, I think
> > > the connect() will fail in any case as I pointed out above (this should be
> > > another point in favour of this change)
> > > 
> > > 
> > > BTW, I think we should explain this more clearly both here and briefly in
> > > the code as well.
> > > 
> > > > > > behavior at other initialization stages: for example, if a connection is
> > > > > > attempted when the guest driver is already loaded, but when nothing is
> > > > > > listening yet, it returns ECONNRESET immediately without any wait.
> > > > > > 
> > > > > > Fix this by checking the RX virtqueue backend in
> > > > > > vhost_transport_send_pkt() before queuing. If the backend is NULL,
> > > > > > return -ECONNREFUSED immediately.
> > > > > > 
> > > > > > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > > > > > Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
> > > > > > Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
> > > > > > ---
> > > > > > drivers/vhost/vsock.c | 10 ++++++++++
> > > > > > 1 file changed, 10 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > > > > index 1d8ec6bed53e..a3f218292c3a 100644
> > > > > > --- a/drivers/vhost/vsock.c
> > > > > > +++ b/drivers/vhost/vsock.c
> > > > > > @@ -302,6 +302,16 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> > > > > > 		return -ENODEV;
> > > > > > 	}
> > > > > > 
> > > > > > +	/* Fast-fail if the guest hasn't enabled the RX vq yet. Reading
> > > > > > +	 * private_data without vq->mutex is deliberate: even if the backend becomes
> > > > > > +	 * NULL right after that check, do_send_pkt() checks it under the mutex.
> > > > > > +	 */
> > > > > > +	if (!data_race(READ_ONCE(vsock->vqs[VSOCK_VQ_RX].private_data)))
> > > > > 
> > > > > Why not using vhost_vq_get_backend() ?
> > > > 
> > > > Because it locks the mutex, which is slow and unacceptable in this hot
> > > > path.
> > > 
> > > ehm, sorry, which mutex are you talking about?
> > > 
> > > I see just a comment about the mutex to be acquired by the caller, but I
> > > don't see any lock there.
> > > 
> > > > 
> > > > > 
> > > > > Also is READ_ONCE() okay without WRITE_ONCE() where it is set ?
> > > > 
> > > > It's racy, but as described here in the comment and in the commit message,
> > > > any possible race outcome is covered by the subsequent checks.
> > > 
> > > Okay, so what is the point to call READ_ONCE()?
> > > 
> > > > 
> > > > > > {
> > > > > > +		rcu_read_unlock();
> > > > > > +		kfree_skb(skb);
> > > > > > +		return -ECONNREFUSED;
> > > > > 
> > > > > This is a generic send_pkt, is it okay to return ECONNREFUSED in any
> > > > > case?
> > > > 
> > > > EHOSTUNREACH would probably be better.
> > > > All the current send_pkt functions only return ENODEV, but it has different
> > > > semantics: they mean that the local device isn't yet ready, while there we're
> > > > dealing with the opposite end not being ready.
> > > 
> > > In the AF_VSOCK prespective, I see ENODEV like the transport is not ready,
> > > so I think it can eventually fit here too, but also EHOSTUNREACH is fine,
> > > for sure better than ECONNREFUSED.
> > > 
> > > Thanks,
> > > Stefano
> > 
> > I think it's worth trying to do the same thing with e.g. TCP
> > and see what error, if any, we get. Match that.
> 
> This case is not directly applicable to TCP: in TCP, there's no out-of-band way
> to detect the "host up, but not initialized yet and not ready for connections"
> state: this could theoretically be ENOPROTOOPT, but no real TCP stack implement
> this, because replying with ICMP_PROT_UNREACH requires a TCP stack, which is
> exactly the thing that isn't up.
> 
> So, in real world, a similar situation with TCP would result in ETIMEDOUT.

Then it just might be best to keep the current behaviour which seems
to match that pretty closely?


> > 
> > 
> > > > 
> > > > Best regards, Polina.
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Stefano
> > > > > 
> > > > > > +	}
> > > > > > +
> > > > > > 	if (virtio_vsock_skb_reply(skb))
> > > > > > 		atomic_inc(&vsock->queued_replies);
> > > > > > 
> > > > > > 
> > > > > > base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
> > > > > > --
> > > > > > 2.53.0
> > > > > > 


