Return-Path: <netdev+bounces-253894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJHrKZPDeGmltAEAu9opvQ
	(envelope-from <netdev+bounces-253894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:54:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 162C2952BF
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A3B730581A9
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A103359F90;
	Tue, 27 Jan 2026 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goHiphA2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0371126ED54
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521572; cv=none; b=qHonRYZBhcIY6n34c4IENvToP8QCvwlY0OLE9kUejkXhNhzfioKs6NHVDI4e8AYCFwTINY6+4oIxowRo8Wl7GTvNFqwdRoiQzbz5tRl/pC2NWBdahsxhIb3ZjC3IQLxDWzuIFixphBEvW/cosUFGNEBWbU6Tov4xQ1tSj71hBas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521572; c=relaxed/simple;
	bh=re6NSiZizBDEm3EpB+1e8HbLc2V1raKduoGD2wp8Pe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyYsIIpXwYGKecVrHYgBrWa5tf4DHCUhrzro3IoUHIJcGDevF9IzJSMPF57YgotpU9Yehqux3JSrZXFBb718LWVlB6Y4cHEog+78FG5C9YsxW5Lh1ETzrp8ltt+31i7G87Bvmz6gnRoWPYDLlSNA5wnoENZToYV5RamTGidBWAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goHiphA2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4327790c4e9so3701193f8f.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 05:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769521569; x=1770126369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x6OQwLQVXz7cUVwRGuGUS5QtspAXdqTx91X6RLYCCic=;
        b=goHiphA2BY86LhXWzMT9cZDXAFvdKVS5K0wRNu/VOX/YDeliq7P1qru4TNUkrV+mW5
         2EpgC/05F8dCeMh/kn3W9x2pM1TlCHtiulznaekt1k2heI1ilxwDFFVhDPvrkOojAJXx
         iXsLxklr5PTjLnYW59zBtkY7cIRpF/mxoqp1ofZkiWl6eaY063h9zl5u1Kv/N95QvTxU
         hfFLR2RAKKd1aKr3PQAFyokEexebiLs/4Qrd8zx4pSC9ezL+K/APnmw5mzYCXMpkKvs9
         oqcpkRrjmpfsAoQmMgjR+AHMK6gbQSw8Uu8pPExDS/tuj3NN8pqDLoPYoHuaF2qOwz9X
         WgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769521569; x=1770126369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6OQwLQVXz7cUVwRGuGUS5QtspAXdqTx91X6RLYCCic=;
        b=IMv6ZoPrTJQ7HebDzDoWxVuQOCYa6BHU38Olv8biPIilDQnFnpzyfzjPRbWG1+p8rN
         UhEKXh5NJLbmrLAaZ2lJhFYmWzK/fijUMkarCdhJMgr6rQE1Bp2NWU3JZaDezAaO3Vor
         2Hm6jjEBshRlOqe2ISX06cn6ySSbdNzhJe0POUCDByDGFpzWP0HssjS76ewk4a4rGP8t
         d1krtmYCBLOGAx3O83Ascoytnp6oWFqX0n4REfTIi6Q6+2421BrXfq42aeA0v+gAzzPY
         2vP0Y26AVsd4CItOVQ77t8mOWy3+X7OAdqmPCI8U3DCjydzjo4F2mo5ZAc5PHR25KAxr
         YW2g==
X-Forwarded-Encrypted: i=1; AJvYcCU7EyffHQoW4KmIOJE80TFe4SMlkPoOCpIZCU3j9yLzZLMPiN1DvHfaMDir8kbtPkACSVRo8zE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw88L9brJrDnF6ra5/IBKEnD2m8aliAUI4IB9AmzOyZgqeqjwkL
	5IEzQWo9Dusvf/T+hPhNOuyyR9GX+bc1LHc9T+EXnX+V/nRIpBBEbT0f
X-Gm-Gg: AZuq6aJrlnp0ycoRAmziS8Gsjr8i2FlvczIMt9oxbHcr5k0fgPWJN+2vqxWl8CsM/zI
	g1rZWwmFOEEveYDMbXHJ2C0gBIPw3IBU08Ox63rahGtGn9T6UF8PTZsBMrg7Cl4oz69aR/yJfSD
	xexi4QgLpV/NUrKiTooUNYXIJFfBWHjgfvan0giWWmvqZc+2AOeHuiM8eXa8XPvXifK7g8Jmm0p
	1s5B8IHFDZ4NughCcmOMg/JHCo59DmUwMtatIOLi59mm0u4YTMajkoe/9Z9b0ahaSjC+VBf9T8Y
	Y5FtP/OopZ717tIIuUlIWw5O6hO7F31JpDpkKFVZWTjiWgoKWyzG3h7OxuQuSkqovrrGNakwMEz
	AjxLmFtRGzUoTGer/9VBhwfrZLYRPywLVm6gNZW8XlRgpvhjIHNvkxKNB8wR4t6jGofeG89gLtd
	OhHzSGmUWWdnRqo7Sk9M9L91g=
X-Received: by 2002:a05:6000:2c0c:b0:42b:3806:2ba0 with SMTP id ffacd0b85a97d-435dd02dc43mr2250887f8f.2.1769521569105;
        Tue, 27 Jan 2026 05:46:09 -0800 (PST)
Received: from debian.local ([2a0a:ef40:e94:5d01:a218:5589:9f9c:4f52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24a8asm37902764f8f.12.2026.01.27.05.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 05:46:08 -0800 (PST)
Date: Tue, 27 Jan 2026 13:46:06 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-intel-wifi@intel.com" <linux-intel-wifi@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
Message-ID: <aXjBnu8MAg5ly76z@debian.local>
References: <20260125233335.6875-1-chris.bainbridge@gmail.com>
 <DM3PPF63A6024A93B1437A144E82CC38B7AA393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aXcovK8uhsiaHumT@debian.local>
 <DM3PPF63A6024A907097A88AEB32669C1E5A393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAP-bSRZ60CSEtR-_9OL6k_Lzg=w8MtD2i79KpwF+nYYzgak=-Q@mail.gmail.com>
 <DM3PPF63A6024A9FCE1CF29C0492A406E7AA390A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aXit5795WQLL290t@debian.local>
 <DM3PPF63A6024A91EFB76D52F9590E82C30A390A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PPF63A6024A91EFB76D52F9590E82C30A390A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253894-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisbainbridge@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:email,debian.local:mid]
X-Rspamd-Queue-Id: 162C2952BF
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 01:22:06PM +0000, Korenblit, Miriam Rachel wrote:
> 
> 
> > -----Original Message-----
> > From: Chris Bainbridge <chris.bainbridge@gmail.com>
> > Sent: Tuesday, January 27, 2026 2:22 PM
> > To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
> > Cc: kvalo@kernel.org; Berg, Johannes <johannes.berg@intel.com>;
> > benjamin@sipsolutions.net; gustavoars@kernel.org; linux-intel-wifi@intel.com;
> > linux-wireless@vger.kernel.org; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
> > 
> > On Tue, Jan 27, 2026 at 05:05:31AM +0000, Korenblit, Miriam Rachel wrote:
> > >
> > > Just making sure: have you been able to reproduce the assert
> > (ADVANCED_SYSASSERT in the log), and then the panic didn't happen?
> > 
> > Yes, the ADVANCED_SYSASSERT was logged but there was no subsequent null
> > pointer dereference.
> > 
> > > If yes, please test the attached patch, which is supposed to fix the assert itself.
> > With this, you are not even supposed to see an assert.
> > 
> > I ran this through 15 suspend/resume cycles with network traffic. The
> > ADVANCED_SYSASSERT did not occur, so it looks like the patch does fix the
> > SYSASSERT. There was a warning logged once out of the 15 cycles:
> > 
> > I think that this is probably a different bug though - checking previous logs with
> > journalctl, I see the same warning occurred once with 6.17.0-06871-
> > gf79e772258df which predates the "remove STATUS_SUSPENDED"
> > commit.
> 
> Thanks for the help!
> 
> Regarding the warning, please open Bugzilla ticket for that
> 
> Miri

Sure, ticket is https://bugzilla.kernel.org/show_bug.cgi?id=221017

