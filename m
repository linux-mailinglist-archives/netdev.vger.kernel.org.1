Return-Path: <netdev+bounces-48099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D12F7EC840
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A97EAB20B33
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7591931756;
	Wed, 15 Nov 2023 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="p633r7Bx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF031755
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 16:14:10 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E72CC
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:14:09 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc3216b2a1so55156865ad.2
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700064848; x=1700669648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTCjyeTH3cX9fhqDGQ0kYumqDVFAGEVz5sOZJI6Fmmc=;
        b=p633r7BxseyXEyYD4g+qS7QQi0R67eFeUmiOAu0p7BZ9CzVKvgz8sO+tWhpEHPWZAn
         5kMcz+oDzhi+/oFiBQxk53GEaPwqpOERWVk/eRaQWOX3X6CRdtujVJUXS1SzyB+XzTUz
         TP/7KhhPG7ln2CJoFtgc6stjvCoQ+TNgWhI3IxHHjlCZHEYLTvcIgGxoh2oPqc61cqi6
         24yrBHlFd4mj36eRzDAPzqUfGbd6t7hlxHvnNMYRsbOLzbG3DX9uz9rYJ9BUdHQOK1Pm
         ceodcXIu3+lFetPgGnb/HXpUcOnLPpKmYlgVel9lj0N/5gHSmoCE3w0f7/7ewVgp3N9s
         iqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064848; x=1700669648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTCjyeTH3cX9fhqDGQ0kYumqDVFAGEVz5sOZJI6Fmmc=;
        b=D6OPg8IiTH2Sh1vzNBoP/IaurRwSXyX7CwEijDSylhZ9719ePOH7cvIH+b7W++3XOG
         5JDiI+isEOroilgTEqw0auOe5DOW1x4XdXObuTk9miTt7Z+51oim9L5UdJLGl/naU2SX
         Q8jml7Xx/Xyb8YpeCZNizJrgPIsFbZhOTC+55LOUxrH8M9FXdHEUSKJ1m1CmD5lah68K
         5ggKWRRkGwu1fODrYE6cRzIQ0UFyexV5V+kPOkvxLISZDbfim2ZP22z94O4mF9l+7OFI
         N0MP845PschbxBHOfKuBaXV/qNIyVtrRUfR0W+bd4pM6TOAANNhROPCzzObj8DIOrjKo
         xD8Q==
X-Gm-Message-State: AOJu0Yyrr21E9FW3EVCpry5JLAI9cvRsPYMWZcGsbY3NFIpBvDQkY0w2
	nc6ls2LK9vUgh69EdwwLwW8lOw==
X-Google-Smtp-Source: AGHT+IFPxVuantrSxAcCvMlrCYYrRgIhtNjOf+BcgTmeK5U97bC0eKioUiPx7iEOm5vGs5yo7yxYQw==
X-Received: by 2002:a17:902:8c96:b0:1cc:47d5:b761 with SMTP id t22-20020a1709028c9600b001cc47d5b761mr5496398plo.35.1700064848428;
        Wed, 15 Nov 2023 08:14:08 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id j9-20020a170903024900b001b8b1f6619asm7600557plh.75.2023.11.15.08.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:14:08 -0800 (PST)
Date: Wed, 15 Nov 2023 08:14:06 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Long Li <longli@microsoft.com>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Message-ID: <20231115081406.1bd9a4ed@hermes.local>
In-Reply-To: <20231110120513.45ed505c@kernel.org>
References: <1699484212-24079-1-git-send-email-longli@linuxonhyperv.com>
	<20231108181318.5360af18@kernel.org>
	<PH7PR21MB3263EBCF9600EEBD6D962B6ECEAEA@PH7PR21MB3263.namprd21.prod.outlook.com>
	<20231110120513.45ed505c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 12:05:13 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 10 Nov 2023 00:43:55 +0000 Long Li wrote:
> > The code above needs to work with and without netvsc (the possible
> > master device) present.  
> 
> I don't think that's a reasonable requirement for the kernel code.
> 
> The auto-bonding already puts the kernel into business of guessing
> policy, which frankly we shouldn't be in.
> 
> Having the kernel guess even harder that there will be a master,
> but it's not there yet, is not reasonable.
> 

I wrote the netvsc automatic VF code almost six years ago.
So let me give a little history. The original support of VF's was
done by using a bonding device and script. Haiyang worked hard
to get to work but it could not work on many distro's and had
lots of races and problems.

Jakub is right that in an ideal world, this could all be managed by
userspace. But the management of network devices in Linux is a
dumpster fire! Every distro invents there own solution, last time
I counted there were six different tools claiming to be the
"one network device manager to rule them all". And that doesn't
include all the custom scripts and vendor appliances.

The users requirements were:
 - VF networking should work out of the box
 - VF networking should require no userspace changes
 - It must work with legacy enterprise distro's
 - The first network device must show up as eth0 and it must work.

The Linux ecosystem of userspace but the kernel is a common base.
It was much easier for Microsoft to tell partners to
"use these upstream kernel components" and it will work.
Windows and BSD OS's have a tight binding between kernel and management
from userspace, therefore it is possible to handle things in userspace.

There are still problems (as Long indicated in the patch) because
the VF device does appear in the list of network devices. And
getting the transparent VF support to work in the face of all
the trash of userspace scripts is hard. Part of the problem is
that the state model of Linux network devices is fractured and
poorly documented.

The IFF_SLAVE flag is already used to indicate device is managed
by another driver. It keeps IPv6 from doing local address assignment
and existing userspace should be looking at it. The problem was
that userspace must not see a non-flagged VF device, or it will
get confused.

Microsoft should have exposed only one device in hardware.
Other vendors only expose the VF device and hairpin packets any
pre-processed packets. Part of the problem here is that
VF firmware needs to be updated (too often) and it is a requirement
that VM's do not lose connectivity.

Ideally, several things should happen:
   - Linux should support hiding devices managed by another device
   - the naming of device roles needs to not be master/slave.

   

