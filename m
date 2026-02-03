Return-Path: <netdev+bounces-256214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PxfFJC9gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:19:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B597DD6B5C
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76A47305C3E9
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25667396D00;
	Tue,  3 Feb 2026 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="g836fDOj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45724393DCF
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770110308; cv=none; b=cj9PNN8DUd9f85iMjCdxw7aRyhxZCK/+FKI4nmLWwgwFD7dGE7cSepbdMuLwpA8Yo5phr6mCqU7tr39QaS0tQGBGex1e0ue0ua3TBt1P3Q3Oz98tocgQXpg8jEQq4pH3Ey1AJ04/6LwM17l6CJ0RZFoJDeqr2N9iz0DB/XypyoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770110308; c=relaxed/simple;
	bh=i2r06awZD9WKdhJiD+pzaN0YGlvAZhUGTNGKk/jK6yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5DMmhhEare2oci//xiMrwEuhWkPSKXKk5rviMlrIKRFPVL8X8Kqa+2kN2BEZHRJb71aEwjS6fdYqumxyp8KoU4GeXe4SbkuzDMe6JkHn7XpwUJ5ljZhmITw61w865nBgRYduD1/dYXjRKphYAfM1RTQLbjjKaIjcc4Sw/sJ5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=g836fDOj; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-42fbc305914so4763043f8f.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 01:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770110304; x=1770715104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SRTkYnKEKUdOdOQPX63uQ4OPu6CyQTA/ZAE+NHgtQ5U=;
        b=g836fDOjtPVp6Hc5y2FeE8Whs+n6e8uLNtClTMAXAppacMWE1F8+/3K3gCrpBiCdBe
         F0MWCUDv7zS4BW9NJgtBWIwVHcdQYFf99L3qVCkn0qwWteTwOsn7HO6rH1ZqUVCwNBVF
         W7EyD046AnhbJT4O0sD1U7uI9iTE3jT3UPnz07cMks9dm8RlCsunHER51e7O0xcb1URS
         KXXuBa9GjU5cOTSLrlPdE7SHTe7xEj5GTjqBlrKTmsKWxt3F+sb3WTeKxfouMBvmLZ9M
         P/8bE8nXB58unH9DzUilmHCE3Y3RqIySawHaiJi+dBt5CJbBU79rt1oLzOp8NiyQmJ25
         nHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770110304; x=1770715104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRTkYnKEKUdOdOQPX63uQ4OPu6CyQTA/ZAE+NHgtQ5U=;
        b=JgtP5MJ9ofOZCOQ9zoUzhP3IriYnLwuQTDvRPX0TJ5TX2iVotPpG5RfwF3KgnWgkbj
         3PzbzhbwgeDZ7FhPnILZ9wngFq5uXhsSLnxPnRb2d5GUAYR25ZspzICAowmuTSelQZaA
         5LHfmjrTs5IVwjVj3U2iaZ5f/yoIcypsn+FCuW0+VpjtNUlLM8NKjdaOrLmgBc6iGqSl
         ox3moyG+1tk1lJNmeDwzCT3vrfoim5CGgmayzF6EnhvFf7DNBYtmcoYm7/9UY8HDBNFK
         Gc3xXpLK2uYI6xp/yvevyZi7jLmXJk9x3T11S/1Ry2KFi4+cIYbtu7sewH8i5ztrkYSQ
         z4zg==
X-Forwarded-Encrypted: i=1; AJvYcCWlzZwMoNBdvsmpBntjwId1l+972M9LtcbpiZehkNN4UzR9V6IugAUnvU4VZjLBbpOn6TY0jU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygyNpOL0b/1poRlAxu0/qS7eHMqn5985Q2BGKoO50XLdFet+8m
	s5BbbF0/zuwmzRAXzBIt4SksGIYsNPdNaesjN1u9d8mgm7l26Uzj0UUFbYwl4Ve+tlk=
X-Gm-Gg: AZuq6aI4v6OpGqVxYhOfP8xZfl4Z2YS7p/yxkHxEbl5oNUcXNo8r053Vs+h2GU34khX
	AvvXpQ5qebDK9oGh2rmKkusQM9cFaoM33DHEBieSVDWbQJNq1SmLa/hKUIhFd7XwxZRgEa+a/P2
	AUPOg23d6PJgO8xlkYTS/l2JF/omowx8oK3MwtaAaB7m1L44BcYzUnOBJHv+mLy5fEo2P2V7Raa
	U8UaNdVtk+wys+58wiUCdv94wqyJaC+udvE+Yu0KxQgKNLfqVLRZ2o5zOk3r8LzfhCeP/upQeTw
	e4MaRd2YUDCoSPvFS0gH6BMnZQNSseHLP1L7z26gWzQsfO7ZOn1dDhB9wDpmg+tDTCFz8jl8uUm
	FiIh09dgNA21BWO82sMfn6p0xDX0xiY4Brhm3PIsP+PRYfb6lJR2wQXRCCIynyEhXB1lUjyU3vF
	7v/LBwn5T37Q3KAnQGKvE=
X-Received: by 2002:adf:fdc8:0:b0:436:db8:c4a7 with SMTP id ffacd0b85a97d-4360db8c4b2mr4704705f8f.6.1770110304394;
        Tue, 03 Feb 2026 01:18:24 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e476dsm49388179f8f.4.2026.02.03.01.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:18:23 -0800 (PST)
Date: Tue, 3 Feb 2026 10:18:22 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next V7 01/14] documentation: networking: add shared
 devlink documentation
Message-ID: <u7uicnxkcirhacpzjimss2pqsuhbngg4ticqrz45iqchkk2ha2@t3eem6w6hhur>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
 <20260128112544.1661250-2-tariqt@nvidia.com>
 <20260202194023.412bb454@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202194023.412bb454@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256214-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org,infradead.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B597DD6B5C
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 04:40:23AM +0100, kuba@kernel.org wrote:
>On Wed, 28 Jan 2026 13:25:31 +0200 Tariq Toukan wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Document shared devlink instances for multiple PFs on the same chip.
>
>> diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
>> new file mode 100644
>> index 000000000000..74655dc671bc
>> --- /dev/null
>> +++ b/Documentation/networking/devlink/devlink-shared.rst
>> @@ -0,0 +1,95 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +============================
>> +Devlink Shared Instances
>> +============================
>
>Shouldn't the length of the ==== lines match the title length?
>
>> +Overview
>> +========
>> +
>> +Shared devlink instances allow multiple physical functions (PFs) on the same
>> +chip to share an additional devlink instance for chip-wide operations. This
>> +is implemented within individual drivers alongside the individual PF devlink
>> +instances, not replacing them.
>> +
>> +Multiple PFs may reside on the same physical chip, running a single firmware.
>> +Some of the resources and configurations may be shared among these PFs. The
>> +shared devlink instance provides an object to pin configuration knobs on.
>> +
>> +The shared devlink instance is backed by a faux device and provides a common
>> +interface for operations that affect the entire chip rather than individual PFs.
>> +A faux device is used as a backing device for the 'entire chip' since there's no
>> +additional real device instantiated by hardware besides the PF devices.
>
>There needs to be a note here clearly stating the the use of "shared
>devlink instace" is a hack for legacy drivers, and new drivers should
>have a single devlink instance for the entire device. The fact that
>single instance is always preferred, and *more correct* must be made
>very clear to the reader. Ideally the single instance multiple function
>implementation would leverage the infra added here for collecting the
>functions, however.

How exactly you can have a single devlink instance for multiple PFs of a
same device? I don't really understand how that could work, considering
dynamic binds/unbinds of the PFs within single host and/or multiple VMs
passing PFs to.


>
>> +Implementation
>> +==============
>> +
>> +Architecture
>> +------------
>> +
>> +The implementation uses:
>> +
>> +* **Faux device**: Virtual device backing the shared devlink instance
>
>"backing"? It isn't backing anything, its just another hack because we
>made the mistake of tying devlink instances to $bus/$device as an id.
>Now we need a fake device to have an identifier.

Okay. I originally wanted to use an id, similar to what we have in
the dpll. However I was forced by community to tie the instance to
bus/device. It is how it is, any idea how to relax this bond?



>
>> +* **Chip identification**: PFs are grouped by chip using a driver-specific identifier
>> +* **Shared instance management**: Global list of shared instances with reference counting
>> +
>> +API Functions
>> +-------------
>> +
>> +The following functions are provided for managing shared devlink instances:
>> +
>> +* ``devlink_shd_get()``: Get or create a shared devlink instance identified by a string ID
>> +* ``devlink_shd_put()``: Release a reference on a shared devlink instance
>> +* ``devlink_shd_get_priv()``: Get private data from shared devlink instance
>> +
>> +Initialization Flow
>> +-------------------
>> +
>> +1. **PF calls shared devlink init** during driver probe
>> +2. **Chip identification** using driver-specific method to determine device identity
>
>This isn't very clear.

Hmm, any suggestion to make it cleaner?


>
>> +3. **Get or create shared instance** using ``devlink_shd_get()``:
>
>Just "Call ``devlink_shd_get()`` with the identifier constructed in
>step 2" (?) and then have the points below explain that it gets or
>recreates

Okay.


>
>> +   * The function looks up existing instance by identifier
>> +   * If none exists, creates new instance:
>> +     - Creates faux device with chip identifier as name
>> +     - Allocates and registers devlink instance
>> +     - Adds to global shared instances list
>> +     - Increments reference count
>> +
>> +4. **Set nested devlink instance** for the PF devlink instance using
>> +   ``devl_nested_devlink_set()`` before registering the PF devlink instance
>> +
>> +Cleanup Flow
>> +------------
>> +
>> +1. **Cleanup** when PF is removed
>
>"``.remove()`` callback for a PCIe device is called"
>
>> +2. **Call** ``devlink_shd_put()`` to release reference (decrements reference count)
>> +3. **Shared instance is automatically destroyed** when the last PF removes (device list becomes empty)
>> +
>> +Chip Identification
>> +-------------------
>> +
>> +PFs belonging to the same chip are identified using a driver-specific method.
>> +The driver is free to choose any identifier that is suitable for determining
>> +whether two PFs are part of the same device. Examples include:
>> +
>> +* **PCI VPD serial numbers**: Extract from PCI VPD
>> +* **Device tree properties**: Read chip identifier from device tree
>> +* **Other hardware-specific identifiers**: Any unique identifier that groups PFs by chip
>> +
>> +Locking
>> +-------
>> +
>> +A global mutex (``shd_mutex``) protects the shared instances list during
>> +registration/deregistration.
>> +
>> +Similarly to other nested devlink instance relationships, devlink lock of
>> +the shared instance should be always taken after the devlink lock of PF.
>
>of an instance, not a PF

lock of PF devlink instance. I think that is what the text says, no?


>
>> +
>> +Reference Counting
>> +------------------
>> +
>> +Each shared devlink instance maintains a reference count (``refcount_t refcount``).
>> +The reference count is incremented when ``devlink_shd_get()`` is called and
>> +decremented when ``devlink_shd_put()`` is called. When the reference count
>> +reaches zero, the shared instance is automatically destroyed.
>
>I think AI went too far with the text generation here, this is very
>obvious from the previous sections.
>-- 
>pw-bot: cr

