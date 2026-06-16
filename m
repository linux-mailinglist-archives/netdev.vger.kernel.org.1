Return-Path: <netdev+bounces-299873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kHygCq1eMWrMiAUAu9opvQ
	(envelope-from <netdev+bounces-299873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:33:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C516908A1
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:33:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=HVgGzkTm;
	dkim=pass header.d=redhat.com header.s=google header.b=WCRkvpkc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299873-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299873-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60BC2304C908
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAC2382361;
	Tue, 16 Jun 2026 14:28:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2938379C4A
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 14:28:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620101; cv=none; b=qG6OEW7QXCOKq/XIOamzrwA+8AaEFBT9HmNaHvoncaUV6VWEBK+ORq0SWD0Ne1anDsaD9FoECSVxtDj9UdfySVR9WO813Gcr7wJnpDX0WJKp5gvfIWsP0D4KqouAmYv7RHvRy4cji2CvFTGcXCdvq7JuEl9UzaeHFuXnOhS1NtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620101; c=relaxed/simple;
	bh=Mgo9D7i4SAm1ix+EblDUBSQHvAGRBPGGbt8S1ocsF40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0w+O3sDo9y/Wc3UI7ubUXigmsdOSzbxbH2y7glvoRAPb3iaSIqqfKDO+gN7J/+XOGorGf4uyB2W80LAofJLWGdMkRP3Ck+kGuaQ/o0tGoyhVnyPjlvszXUQUpa26EANg2IIBZgKP9l1zKf+FN14gHZZ7iH7Gkh6pVFnJrFqjBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVgGzkTm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCRkvpkc; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781620099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e3l0uGCFBLNdzhr5oLMo3wkv8DBSjThMgB4WocmXwXI=;
	b=HVgGzkTmhHURXUO4qCbAe0LcvmHKJomiuv43Ciu6fm9LsUErRLq9fZ/BqTJcDVktvZZqQ1
	tcCDzvWlPeNImH0NtsuvHWwoELZK8AVF0B4KrpjbVUkfWvjznoY7cr5PKmpX+1xIjexTj+
	kLJqre1K3kiMCHWkIqZEMgch0j+pyCE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-FLVPDOuNOYuGU2FSDgSAdw-1; Tue, 16 Jun 2026 10:28:17 -0400
X-MC-Unique: FLVPDOuNOYuGU2FSDgSAdw-1
X-Mimecast-MFC-AGG-ID: FLVPDOuNOYuGU2FSDgSAdw_1781620097
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45eebc943bfso3246882f8f.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781620096; x=1782224896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3l0uGCFBLNdzhr5oLMo3wkv8DBSjThMgB4WocmXwXI=;
        b=WCRkvpkcdUPdKArPaBw6uJobvAeaOlvmOIjCCBV+gSP+T7BaMnQSVljbdj++ATNeR5
         0jFUYJ6GdXSl5wSeyqTgefuGuWPB7FVbKTDLgg5HRJfBwXMVG6wcN7PhqBUJXd3G8ox7
         HIdFZcdsyW2wqQW28BHcT1AttQqfKYYysMO0JDRtUyvbQOZgJrUCDpJXCwHLkn61Sfzh
         39ICQaf0yA1uZROMquqixifw/fXGY1bCNUMY1qS4DlBjiGlqRCt5KvQgHh+MUYssBKNy
         vOcKvEpodS63Z5V13s+AiER73IeWomlMPTps6ZdIUAENft6Qd1oGt9dik0XB4ZOAlaaS
         L3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781620096; x=1782224896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3l0uGCFBLNdzhr5oLMo3wkv8DBSjThMgB4WocmXwXI=;
        b=U80RXlX0KJNoAk0GMn9IBkGTShR2tvGHnFuRet5UU06HE+ZccsRRUvm+fV3gfYoY9i
         2ILzHmoE/PV7LQzCBV0gCEOI5m/H4jmxvJLhCT62iMh6i1e189SY1MVHTcApPwdirucu
         a7B23ozgHtxn9RaLueloKQbutmEwSAKqikrqFoqAjZnKrzm0RkV9QtlltlntWINXDpnk
         2bHERvGtw3xx60XgFCGvnAZcf+GGtDbIc58pq/4lqWeixsdeuJThx5SdocDwB6B4Sx4s
         Nd8+n5kufvZ35obD7ct+51fnIWPTWD6atkHkhSM1HgE98zYMq2ajX1D/abagSkGnXY7+
         Aocw==
X-Forwarded-Encrypted: i=1; AFNElJ/kx2lmvghMhjGKdkWZD7Jcy/C97fpyYmCNb7G8IZKwnfDlLM3xrLrkVzzvfObfSmppqI7/yR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0uSLS0bupChQTTIl9X8GaWnXOJGW3HGkJVUu+ySEERGLefau9
	CuEmmjErqgTJa1IBgEWfgfXDMNEg/tYgqax6JyCpxSnpUlnx+BSDV6JCoG+mrlkvjlZW7eSesV0
	/meH9iLeu0kmYglBTZHmfgGmRD9jycJyXy7znJSSzWYROCFJa4oFBwa3IekwmkYyBxA==
X-Gm-Gg: Acq92OHT7mlC4fT+FaNpO0B9Lud07dHFNCKn1hSO85i9AnZErmkP0DX8mFLsC9GwZxy
	rWxg8k91T3oOEIr2B22BvYfQyQ21G+617BAJeZW0NXhC0JuWCgSttlB0Ua+2h28nTpTC2akuvtv
	w7a6DbNzjyz7B6mVrJV/csGLl815hdxBJQVrJTITRWvkOBG5Yd/BygASdRXFySCUr71sKcm0IQY
	pzbCOppiJy2nT80V6zi3WmTHM8F3kqxqJbYap3+Ej8wL4r9mOVYhnZA9vO4wQfhblbYpUVvW3Gf
	MADB4KeJ+3Uh25h6TrdfjFUFtJCbDKpwZPKS8O9f3iBOxreoiyGfgjFWECJL4BqkWf1K4jcTOq1
	xmAm4otkR6+xVWHXj++QLtoV32a4E2jygwWXPoMYRKVhHLFJ3yphzEu+eSz5ck1L7pREshR4=
X-Received: by 2002:a05:600c:a413:b0:490:bbc1:c9be with SMTP id 5b1f17b1804b1-4922fa492b5mr47691335e9.0.1781620096475;
        Tue, 16 Jun 2026 07:28:16 -0700 (PDT)
X-Received: by 2002:a05:600c:a413:b0:490:bbc1:c9be with SMTP id 5b1f17b1804b1-4922fa492b5mr47690935e9.0.1781620095878;
        Tue, 16 Jun 2026 07:28:15 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a9a399sm60380495e9.14.2026.06.16.07.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:28:14 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:28:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 0/4] vhost/vsock: add support for VHOST_RESET_OWNER and
 CPR migration
Message-ID: <ajFdI921uj-nftA7@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <ajFLvKcT-A0wvLYW@sgarzare-redhat>
 <4fa88fa6-a188-4c63-876c-ed748809bf0b@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4fa88fa6-a188-4c63-876c-ed748809bf0b@virtuozzo.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299873-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:andrey.drobyshev@virtuozzo.com,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:mst@redhat.com,m:stefanha@redhat.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sgarzare-redhat:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28C516908A1

On Tue, Jun 16, 2026 at 05:01:34PM +0300, Andrey Drobyshev wrote:
>Hello Stefano,
>
>On 6/16/26 4:35 PM, Stefano Garzarella wrote:
>> Hi Andrey,
>> thanks for the series!
>>
>> On Fri, Jun 12, 2026 at 07:57:14PM +0300, Andrey Drobyshev wrote:
>>> Host<-->guest connections via AF_VSOCK sockets aren't supposed to
>>> outlive VM migration, since VM is moving to another host.  However
>>> there's a special case, which is QEMU live-update, or CPR
>>> (checkpoint-restore) migration.  In this case, VM remains on the same
>>> host, and we'd like such connections to persist.
>>
>> In the spec we have VIRTIO_VSOCK_EVENT_TRANSPORT_RESET which is usually
>> sent by the device after a migration.
>>
>> IIUC the specs don't say this has to be done all the time, so we don't
>> need to change anything in the specs, right?
>>
>> We just need to avoid sending it (which I think is what we're doing
>> here... I still need to look at the patches).
>>
>
>Sending this exact ioctl is guarded by one of my patches in the QEMU
>counterpart series:
>
>https://lore.kernel.org/qemu-devel/20260612165110.431376-6-andrey.drobyshev@virtuozzo.com/
>
>So we indeed avoid sending it on migration target in case of CPR migration.

Great, so we are aligned :-)

>
>>>
>>> For this to work, we need to be able to transfer device ownership from
>>> source QEMU to dest QEMU.  Namely, source needs to reset ownership by
>>> issuing VHOST_RESET_OWNER ioctl, and then target has to claim it by
>>> calling VHOST_SET_OWNER.
>>>
>>> Since VHOST_RESET_OWNER isn't yet implemented for vhost-vsock, let's add
>>> such implementation (patches 1-2).  Also fix regression introduced by
>>> the earlier commit [1] (patch 3), and fix the deadlock bug (commit 4).
>>
>> If it's a regression, should we fix it separately?
>>
>> Or is it related to this series?
>>
>
>Probably my wording wasn't quite correct.  I posted this patch here
>because we found the problem during testing this particular
>functionality, i.e. vsock data transfer + CPR migration.  And the
>problem was introduced by a recent commit, which is fine on its own, but
>breaks the CPR case.

Yeah, I figured out while reviewing the patch.
I'd avoid "regression" here and use just "issue", because at the end is 
just affecting this work that is not yet merged, so it can be a 
regression.

Thanks,
Stefano


