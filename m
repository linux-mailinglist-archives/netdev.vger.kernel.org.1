Return-Path: <netdev+bounces-252422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHkZGhdWcmkpiwAAu9opvQ
	(envelope-from <netdev+bounces-252422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:53:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CB86A640
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92FC4300A4DD
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED7844D011;
	Thu, 22 Jan 2026 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2Rj+KiD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F304360758
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097694; cv=none; b=G3YLCcdpVrOyRIBhGH7cnSZLFfta76U5F7Aj774btfflDDd7QyOym2buvbvqxwxhCpvDQRHlXVZkJIyrI4wq5JJpzKWVbd2z3+vSAgF/FN/+eUs2AnML6Cp8UoaCT3/IZaZ5nX/Fp5VNGAFjR5R2SH94dCVYIDLIfA5B0kFJYNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097694; c=relaxed/simple;
	bh=9JzOfqiTFO39kgxFQWVLYY5umNJRQRPCw/NtCy7HzoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV/DQNf9yBgDVnRh3Iek12xicCSrYAcW2YiNKrBHMnN6CRAUPI3IYCHSkX9kjVf8Z+ZECUbsdMCS8R2B1EKhUccqblE9MdsqIQnU2mie3CN4DiYtqZTza3U0kRuaxXvDoGgj/sh97ZzeFj5KtiMMgA/QNok0gtpUcq7NNnhGFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2Rj+KiD; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-649389b1cc5so1157542d50.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 08:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097688; x=1769702488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4nNXaOW8SsH8VsbBiV479RmC0+eq7tMcFo5rcunlQoQ=;
        b=l2Rj+KiDdtD2q2NtiGMA5033btXx9v484iJj7k8xvoYFUvON0uWN//Nj0B5cEZyYul
         k8z+xwAcG4QnP/VahCqMOrvr3kNZJu14BB2o8opiF+eHpFAxpgElXJ6ycHbEVZkbIRD7
         rpdBZZfPcAObZ4iovLDSomfuB/s4pjTq2lFUqlmgqWdE6oJy5RUYj5cZe9uGJHN0M494
         llfIRIqnvzfZwBz14cODqAs3+Sa9Ytcpw6atLylFbOKCh0RbvLu7V39tzPsAij/QIppG
         Kn19Zf7i/MnoUjTB2+4IWB1BZUNurieL8640i6M9ASZR7pjIn3vnLTbALhflJdeG896f
         VXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097688; x=1769702488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nNXaOW8SsH8VsbBiV479RmC0+eq7tMcFo5rcunlQoQ=;
        b=id4Jeh1H3VBrCaUyg6/6sM1z85wqFlbfWZcxpnWUnqEVYevw4DI4vwxFTNjKWy1Qfy
         Ix48WfLHFSCkVCQ4GbOoAytGOAhBGNi9b5qHu0ULyBzKCEx0ogUDbGkPqm8XtUTIQgf3
         jTzyN8kX2rMQj1JuT166fXBp4CHfcniYHje33hLSBMEvjT8S8OatpWNA0gdkDy5AU3ZF
         y35rBiTI5OsOsgs+vXzl+anP21ZFLWKdAIIbWtrXxy6UVSwAY8tv+8KQyVWjUuJ5s6tq
         rkeAGOBT7KDLg1zUrN3WzkYpJfvgW8s5c077oAdPDAEfa+Q/VuOOnvM2QW71JFVzorWR
         cjXg==
X-Forwarded-Encrypted: i=1; AJvYcCXwoNsjq4O6JRD6FdqB7G1RsEG1HeMIx0zZLSKYXBW+PpDaSV8ohUrj/D9WYlll6kKj8FclvQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQCWyAzmn8j6lJeAsDuakC29VLAKu38WIUxCf3mzr5KjB9eBG
	mNc03ExAzDwJ9Z6ezmd+MylKOqNWuG1SxinAcj35UjucIu1/muyZCkCO
X-Gm-Gg: AZuq6aIWGLqkFfmdnGwLmxR7op6mvk9yi70LCRVOHETZ0tj2Hnh2RBRQAr8xVYWIlLX
	Eg5oRqAsCnojMtmrwFVosUZe673LzXqA3EW/XkBUpe4Uz2x0HERL1EFop0aoVJ7kt6jNbJNcFTQ
	2mYGQr6iv768JvPY+FjKUq1DLPrjg4QmflhudJ0la+fbTAk+m4Y5WCBWbn+g+juKyBSVt7j1MFD
	W38Qbj/g34L18H2cz3quamvtTnxkGJ4zLdDlKo7TIlawtC7hxBrbUWzpXcTNDO0zbPiRJwJEf8Q
	dHWpjWckEJRF51qScbfiUAtHelG+uOrWHG0+EAXzQeisU0jgJ34ydBZ93uktABXKxu7MwnSYRu1
	5DzO8oDUVCvP4FEY24WgGaTU3Rcqeya0+FSxbYSeyFw/BIf0Rl8OqYxwt4R6+Rih9irTL2eoURq
	CdMUJBOyzVZXATbn3Q2YD0mJKjk0Us4gG4ng==
X-Received: by 2002:a05:690e:d8b:b0:649:4689:c4a9 with SMTP id 956f58d0204a3-6494689c534mr4815658d50.89.1769097685513;
        Thu, 22 Jan 2026 08:01:25 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649170acbdbsm9523979d50.13.2026.01.22.08.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:01:24 -0800 (PST)
Date: Thu, 22 Jan 2026 08:01:23 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, berrange@redhat.com,
	Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v16 00/12] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <aXJJ0yjZB5mT162B@devvm11784.nha0.facebook.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
 <aXH7YCgl0qI2dF1T@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXH7YCgl0qI2dF1T@sgarzare-redhat>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252422-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00CB86A640
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 02:55:36PM +0100, Stefano Garzarella wrote:
> On Wed, Jan 21, 2026 at 02:11:40PM -0800, Bobby Eshleman wrote:
> > This series adds namespace support to vhost-vsock and loopback. It does
> > not add namespaces to any of the other guest transports (virtio-vsock,
> > hyperv, or vmci).
> > 
> > The current revision supports two modes: local and global. Local
> > mode is complete isolation of namespaces, while global mode is complete
> > sharing between namespaces of CIDs (the original behavior).
> > 
> > The mode is set using the parent namespace's
> > /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
> > created. The mode of the current namespace can be queried by reading
> > /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
> > has been created.
> > 
> > Modes are per-netns. This allows a system to configure namespaces
> > independently (some may share CIDs, others are completely isolated).
> > This also supports future possible mixed use cases, where there may be
> > namespaces in global mode spinning up VMs while there are mixed mode
> > namespaces that provide services to the VMs, but are not allowed to
> > allocate from the global CID pool (this mode is not implemented in this
> > series).
> > 
> > Additionally, added tests for the new namespace features:
> > 
> > tools/testing/selftests/vsock/vmtest.sh
> > 1..25
> > ok 1 vm_server_host_client
> > ok 2 vm_client_host_server
> > ok 3 vm_loopback
> > ok 4 ns_host_vsock_ns_mode_ok
> > ok 5 ns_host_vsock_child_ns_mode_ok
> > ok 6 ns_global_same_cid_fails
> > ok 7 ns_local_same_cid_ok
> > ok 8 ns_global_local_same_cid_ok
> > ok 9 ns_local_global_same_cid_ok
> > ok 10 ns_diff_global_host_connect_to_global_vm_ok
> > ok 11 ns_diff_global_host_connect_to_local_vm_fails
> > ok 12 ns_diff_global_vm_connect_to_global_host_ok
> > ok 13 ns_diff_global_vm_connect_to_local_host_fails
> > ok 14 ns_diff_local_host_connect_to_local_vm_fails
> > ok 15 ns_diff_local_vm_connect_to_local_host_fails
> > ok 16 ns_diff_global_to_local_loopback_local_fails
> > ok 17 ns_diff_local_to_global_loopback_fails
> > ok 18 ns_diff_local_to_local_loopback_fails
> > ok 19 ns_diff_global_to_global_loopback_ok
> > ok 20 ns_same_local_loopback_ok
> > ok 21 ns_same_local_host_connect_to_local_vm_ok
> > ok 22 ns_same_local_vm_connect_to_local_host_ok
> > ok 23 ns_delete_vm_ok
> > ok 24 ns_delete_host_ok
> > ok 25 ns_delete_both_ok
> > SUMMARY: PASS=25 SKIP=0 FAIL=0
> > 
> > Thanks again for everyone's help and reviews!
> 
> Thank you for your hard work and patience!
> 
> I think we've come up with an excellent solution that's also not too
> invasive.

Thanks, and I appreciate all of the work you and other maintainers put
into this as well! I think we honed in on a great solution too.
> 
> All the patches have my R-b, I've double-checked and tested this v16.
> Everything seems to be working fine (famous last words xD).
> 
> So this series is good to go IMO!
> 
> Next step should be to update the vsock(7) namespace.

Sounds good, I'll follow up with that and CC you + other reviewers that
participated here.

Thanks again,
Bobby

