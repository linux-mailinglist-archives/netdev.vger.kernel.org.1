Return-Path: <netdev+bounces-268749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBH+ObHKuWl/NgIAu9opvQ
	(envelope-from <netdev+bounces-268749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:42:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D88D2B2D3F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 883FF312B526
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 21:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019A7396D25;
	Tue, 17 Mar 2026 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6A5qf3Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE0395DA9
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783665; cv=none; b=fDkmzQtZJY1FEKjMdD/PJxGZT9ylBtYaSXfAlFAfXfE9VdZypSRbrnOWyJ+zM9qnpFRe41lSasT7qr2PfmZwPXSSpl52/8MAlA6r+2U+2tPdZi++qUxa5HODCI4KdcyQZjgj8zO2k6CHBju/oII6T6AIfA3UhVC4jiPQ51QcmV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783665; c=relaxed/simple;
	bh=09hOL83tVBr/LihHmyAvXs8Awpdqkkb+fou4oZHmcko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=We09NZ+9CHhjwhmQiXFrtKqL3RrWXahbdN8IK7lQ74bX4N6DIvQGrTVCgon5ucefv4878DjfD4kDvkU/etshOih5OaKBA20W+Ii9ILfUK9mlL2WDNibuIT+BSHdReByTKYsB9ToW65C++FULz008z2Rdiqhc2Lnh4fsgQS6nduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6A5qf3Z; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ad019bbd4so6515557d50.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773783663; x=1774388463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fdMk8K9gKZoM6sms8pJWkdJXlxOeTpf/a44ocaiQWz4=;
        b=Y6A5qf3ZET9WUMmFsT3KrH7uWoy7W+V0xkCZ0YI3VZWDtimiHkkvj4jM2m2R/558DT
         mEwIhce5MIZrYsXwlXungJGLA7l9XHVoPIU9Zt4zruR52v1ekl4+4PeuX09bSHzHjFpm
         6ncwtCA1MiTsti+5cmrRZglQhogIxSzRwxQS9VGWNL4Q78UU0ZYoRVMmWlwojvxalMnf
         iD4UuJzfZlxzQ01xbUxgAaWLWW8I1fai8PX9aRy9M2VJ5qb4i7zZLjIAJN6eHfoE7XGv
         3OCyFD2RY0WBiF4v3niA9K2DJ5qLRdhkdpaqZfuEmrGSitmf1ReYK57SAS7nYwlSBvT2
         lKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773783663; x=1774388463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdMk8K9gKZoM6sms8pJWkdJXlxOeTpf/a44ocaiQWz4=;
        b=noTlGumzxwDoQtcsYftz4LeJRmVb9FSKSBQK7imKO4n8JXKrPgpg1aCx+toheFN9pw
         cGbI9NvsLpn1KXxIwKQejOCL9FihP3i2K9PPoj5w+Rjq54daAldkjzR6eHKahh6DIZ7Q
         qXY6SM7OuXFrKp7Z7qiPMW1YVjgkrRXL+B3AaW9FsU4EKzuHSM5Ct2PyOPx2MBpZ4ecS
         Y7osCzRR8n5qGMEcHx3b984mKbrl7hCwl/8/6cMrVIipeRLGN8VqOePtDgyuuZgVCbg1
         ZeFvpmi72g1FsThkslJY4bT2cjUpkE7MJ3NM3mq7Ixa7V9jH9jR6w28xlYRGsuVY5AdE
         ziag==
X-Forwarded-Encrypted: i=1; AJvYcCXbDzRZr7XOo9IHwPUlE99hPrb09EVh+EVMpYJwq3ExUvkYS0gHbDeSa/iBCkz1z0kRpF0SQsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZwNjsdd7Q3XHay9J3iw/FELRwvedfVmNn492UIq65QkNnxabC
	3s3YhhCemfzY0PPqt1ZgmG576Ua/GpLQVcEtWDSfJNzhKJJPiCWnpeT8
X-Gm-Gg: ATEYQzyXjgv0JEwlg4s5CTc7KhPtZ41HWou3XzifZ4mHOYt3llFNJDgEilKAtHs0QyE
	GmfZqM0HRfJB8HzXi1PPdOyCQMYGFmjbv4RHgDhZci9knouPHyW8Ft68XksUBqEBXIQkaS/SDsf
	3TFiZoeNx0cNxPT6arwdZLock/fKjzr8nHAkV9dfh6D4vCMVUuNGrZ4E2K8zlaUdQFycHwESZTJ
	nG5j+uSZ+h7P4PXYWw+Xy83uxqu6l72srs/NxRvLZWXgktV/JLGBdO68tlw08FRlrjiJRCsVQ4P
	ApMbi/fgFOEAcoNMKVlkMwyj9aF1D9L6xOXeoJlfd22JjYIuitSn4hhS4ksbsnwtYHFKqkFCtJY
	puhkyfdLQq+rXTnQ5OzV3IdneZIPEoDBIiFSQ5G7SX9zmrmF9aXFHanGE/4S8+0YkIt2hD2GFvS
	r0k2dign81O4OMP5h/Ie2OH/rZ16nSqmqpRIMIEh2RR5Rh6ZnYoCMv2Va4zg==
X-Received: by 2002:a05:690e:1a1f:b0:64c:2581:eed9 with SMTP id 956f58d0204a3-64e916057d2mr1018690d50.70.1773783663011;
        Tue, 17 Mar 2026 14:41:03 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91c2b32fsm509608d50.18.2026.03.17.14.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 14:41:02 -0700 (PDT)
Date: Tue, 17 Mar 2026 14:41:01 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 1/2] selftests/vsock: fix vmtest.sh for
 read-only nested VM runners
Message-ID: <abnKbaZ0Y9cfEXcD@devvm11784.nha0.facebook.com>
References: <20260313-vsock-vmtest-nested-fixes-v1-0-d0e6274c3193@meta.com>
 <20260313-vsock-vmtest-nested-fixes-v1-1-d0e6274c3193@meta.com>
 <302d1a45-dd5d-4d50-a99c-ce73de196d0c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <302d1a45-dd5d-4d50-a99c-ce73de196d0c@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268749-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: 6D88D2B2D3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 03:46:35PM +0100, Paolo Abeni wrote:
> On 3/14/26 1:00 AM, Bobby Eshleman wrote:
> >  tools/testing/selftests/vsock/vmtest.sh | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index 86e338886b33..c2cfcdf05d99 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -42,6 +42,8 @@ readonly KERNEL_CMDLINE="\
> >  	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
> >  "
> >  readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
> > +readonly TEST_HOME=$(mktemp -d /tmp/vmtest_home_XXXX)
> 
> shellcheck complains:
> 
> In vmtest.sh line 45:
> readonly TEST_HOME=$(mktemp -d /tmp/vmtest_home_XXXX)
>          ^-------^ SC2155 (warning): Declare and assign separately to
> avoid masking return values.
> 
> > @@ -451,11 +464,14 @@ vm_start() {
> >  		--run \
> >  		${kernel_opt} \
> >  		${verbose_opt} \
> > +		--rwdir=/root=${TEST_HOME} \
> 
> And here, too:
> 
> In vmtest.sh line 467:
> 		--rwdir=/root=${TEST_HOME} \
>                               ^----------^ SC2086 (info): Double quote
> to prevent globbing and word splitting.
> 
> Did you mean:
> 		--rwdir=/root="${TEST_HOME}" \
> 
> The first occurrence could possibly be explicitly silenced explicitly,
> but it's probably better to really address the latter.
> 
> /P
> 
> 

That makes sense, fixing both and resending now.

Thanks,
Bobby

