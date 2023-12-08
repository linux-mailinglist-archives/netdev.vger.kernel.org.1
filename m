Return-Path: <netdev+bounces-55488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DF880B098
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 00:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA9D1F21338
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AA85ABA7;
	Fri,  8 Dec 2023 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PiarAZ04"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3682137
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 15:30:59 -0800 (PST)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0E12941516
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 23:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702078258;
	bh=W4YmvBWrOBzInEYUWdzBgaE35XDrnqoquNNpR5Ozyw8=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=PiarAZ040GF33p0jb9r+7mORf6YvF2Y81kDg5YRAQy6dVNKZYUgxRepXktTJegJsD
	 yVe+6nrG1tLiJ1f5BDWzNp7sMtACj6rgCf2/hw4qXPqv6tf8uq210AXyaYiggcn9Lt
	 d8dD5DAHI3FGS0vV//2nhJGSd0jIVj4ht91jsUba/QO2p2G5RZ03WWfqAomQaWGhX/
	 aQA0ZwBoyJgtnFvv0RJPv1YV80f1WIB9HOIo5ofOSuG4DUBbt1QL7nWmBc6GMgSy3K
	 pc+EGYVQjf7+Z01AAalIHVGWsB5kEz/k48McVOPTVj63Kris+NgFrew9z6curr5iCF
	 iF9mp6zY6CVZQ==
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35d62f23044so25515075ab.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 15:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702078256; x=1702683056;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4YmvBWrOBzInEYUWdzBgaE35XDrnqoquNNpR5Ozyw8=;
        b=w74H226pKwhEJ+A/aKCQYAaFmP5FemLZykmuBNRKQaM4YnxHdENEUDeekBgsvLRxga
         q9bHwAJS0RLFIgD4r+BAbONN0oCVi8evGbHtVNhJDF+/BI1F8CkLUkXVH5b1BkeHuz8G
         cyaz8hxWD9lcwPKIE0TsiGENmZz6pxASFbCGg+eoCxZWqrjCavg6Yyibp0YJFaBGMm9X
         QH0PhSgiUD2BMOMWtMTEz6pqsfhl6iizJShkcr7Py/K+QTsugThJyuqNQ/b1O3EEoTUl
         I/LqWhtlEMuxby8ylA/ouS7KGr5sK2BK9t6P4Se+vGSos98ksDdezYTvgaN/TQnraJVg
         fIWA==
X-Gm-Message-State: AOJu0Yw9nC6i10Vtl4ptB+e3DqWfRL5sfEFgmYPXQOtvOBRhwOagiv+e
	X35v2U4qaT9fMTlZPuNPZ8KLUgKBcqrKtmX3WLyYG3ICM1Qdw8R8UGhDJMgWWHA5Vai87vrx04H
	VaK4F71c5aCOPPBzFifAsdVwGBwMVlfrZCoaPvTtG8g==
X-Received: by 2002:a92:cdae:0:b0:35d:59a2:1285 with SMTP id g14-20020a92cdae000000b0035d59a21285mr1173532ild.49.1702078255928;
        Fri, 08 Dec 2023 15:30:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfsWTaPFJlhMNBh4Ocy0DObSJXiXWvrbBSbZz0L4YyFpOPyuwVQUfGjYVcOrHUq4/BJxnsEw==
X-Received: by 2002:a92:cdae:0:b0:35d:59a2:1285 with SMTP id g14-20020a92cdae000000b0035d59a21285mr1173517ild.49.1702078255572;
        Fri, 08 Dec 2023 15:30:55 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902694a00b001d0ba4513b0sm2232119plt.287.2023.12.08.15.30.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2023 15:30:55 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id CCFF25FFF6; Fri,  8 Dec 2023 15:30:54 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id C52D09F88E;
	Fri,  8 Dec 2023 15:30:54 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: "Ertman, David M" <david.m.ertman@intel.com>
cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
    "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
    "Brandeburg,
    Jesse" <jesse.brandeburg@intel.com>,
    Robert Malz <robert.malz@canonical.com>,
    Heitor Alves de Siqueira <heitor.de.siqueira@canonical.com>
Subject: Re: [PATCH iwl-next] ice: alter feature support check for SRIOV and LAG
In-reply-to: <MW5PR11MB581150E2535B00AD04A37913DD8AA@MW5PR11MB5811.namprd11.prod.outlook.com>
References: <20231207182158.2199799-1-david.m.ertman@intel.com> <bca6d80f-21de-f6dd-7b86-3daa867323e1@intel.com> <MW5PR11MB581150E2535B00AD04A37913DD8AA@MW5PR11MB5811.namprd11.prod.outlook.com>
Comments: In-reply-to "Ertman, David M" <david.m.ertman@intel.com>
   message dated "Fri, 08 Dec 2023 22:24:06 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21389.1702078254.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Dec 2023 15:30:54 -0800
Message-ID: <21390.1702078254@famine>

Ertman, David M <david.m.ertman@intel.com> wrote:

>> -----Original Message-----
>> From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
>> Sent: Friday, December 8, 2023 1:18 PM
>> To: Ertman, David M <david.m.ertman@intel.com>; intel-wired-
>> lan@lists.osuosl.org
>> Cc: netdev@vger.kernel.org; Brandeburg, Jesse
>> <jesse.brandeburg@intel.com>
>> Subject: Re: [PATCH iwl-next] ice: alter feature support check for SRIO=
V and
>> LAG
>> =

>> =

>> =

>> On 12/7/2023 10:21 AM, Dave Ertman wrote:
>> > Previously, the ice driver had support for using a hanldler for bondi=
ng
>> > netdev events to ensure that conflicting features were not allowed to=
 be
>> > activated at the same time.  While this was still in place, additiona=
l
>> > support was added to specifically support SRIOV and LAG together.  Th=
ese
>> > both utilized the netdev event handler, but the SRIOV and LAG feature=
 was
>> > behind a capabilities feature check to make sure the current NVM has
>> > support.
>> >
>> > The exclusion part of the event handler should be removed since there=
 are
>> > users who have custom made solutions that depend on the non-exclusion
>> of
>> > features.
>> >
>> > Wrap the creation/registration and cleanup of the event handler and
>> > associated structs in the probe flow with a feature check so that the
>> > only systems that support the full implementation of LAG features wil=
l
>> > initialize support.  This will leave other systems unhindered with
>> > functionality as it existed before any LAG code was added.
>> =

>> This sounds like a bug fix? Should it be for iwl-net?
>>
>
>To my knowledge, this issue has not been reported by any users and was fo=
und
>through code inspection.  Would you still recommend iwl-net?

	We have a customer experiencing intermittent issues with
transmit timeouts that go away if we disable the LAG integration as
suggested at [0] (or don't use bonding).  This is on the Ubuntu 5.15
based distro kernel, not upstream, but it does not manifest with the OOT
driver, and seems somehow related to the LAG offloading functionality.

	There was also a post to the list describing similar effects
last month [1], that one seems to be on an Ubuntu 6.2 distro kernel.

	Could these issues be plausibly related to the change in this
patch?

	-J
	=

[0]
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2036239/comments/40
[1]
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20231120/03=
8096.html



>DaveE
> =

>> > Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>> > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
>> > ---
>> >   drivers/net/ethernet/intel/ice/ice_lag.c | 2 ++
>> >   1 file changed, 2 insertions(+)
>> >
>> > diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c
>> b/drivers/net/ethernet/intel/ice/ice_lag.c
>> > index 280994ee5933..b47cd43ae871 100644
>> > --- a/drivers/net/ethernet/intel/ice/ice_lag.c
>> > +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
>> > @@ -1981,6 +1981,8 @@ int ice_init_lag(struct ice_pf *pf)
>> >   	int n, err;
>> >
>> >   	ice_lag_init_feature_support_flag(pf);
>> > +	if (!ice_is_feature_supported(pf, ICE_F_SRIOV_LAG))
>> > +		return 0;
>> >
>> >   	pf->lag =3D kzalloc(sizeof(*lag), GFP_KERNEL);
>> >   	if (!pf->lag)

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

