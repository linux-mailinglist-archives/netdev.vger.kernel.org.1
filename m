Return-Path: <netdev+bounces-55953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F9A80CF46
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FD9281AF3
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BDD4A9BC;
	Mon, 11 Dec 2023 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnaNmQrg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ED84A9AE
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 15:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8E0C433C7;
	Mon, 11 Dec 2023 15:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702307823;
	bh=+7xaZHCEReXLiHg4uE2jmuXbc5piUceJjBYT0cz0lR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EnaNmQrg5tQmIAu29CozoPxM8dfsAXGYElFYieadsSdQrPICykpcqgPvym0DA7X7r
	 sXPpjePqoSGJoCe/HUL7oYE2ql3Kl0vWjSKVYDxyQ7E8FUOE30ktLlCQhS5kzIrEdk
	 zjpn2kzJobjlzqZW0OIEoeB8u+DNXAg7dbshVBeVd+PMM2go9ouRvs0x0OkVrHQHWh
	 Z0b3L59Mt5diZ54fXeROIW6xEv3V5FTxsK5UX95LduxWGLiD3p6DaovBoZU4Cx3EAG
	 9OyDudxRwO0pRsBs2a1D5qh2wfGp1dYTTX1pSmoJ2DH4cAEg0ADKOv60LN6TnKerfk
	 jAVn7SDUB1EIQ==
Date: Mon, 11 Dec 2023 17:16:58 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Haseeb Gani <hgani@marvell.com>,
	Vimlesh Kumar <vimleshk@marvell.com>,
	"egallen@redhat.com" <egallen@redhat.com>,
	"mschmidt@redhat.com" <mschmidt@redhat.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"wizhao@redhat.com" <wizhao@redhat.com>,
	"kheib@redhat.com" <kheib@redhat.com>,
	"konguyen@redhat.com" <konguyen@redhat.com>,
	Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh B Edara <sedara@marvell.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [EXT] Re: [PATCH net-next v3 2/4] octeon_ep: PF-VF mailbox
 version support
Message-ID: <20231211151658.GI4870@unreal>
References: <20231211063355.2630028-1-srasheed@marvell.com>
 <20231211063355.2630028-3-srasheed@marvell.com>
 <20231211084652.GC4870@unreal>
 <PH0PR18MB4734652F50856F52507577ADC78FA@PH0PR18MB4734.namprd18.prod.outlook.com>
 <20231211112305.GD4870@unreal>
 <PH0PR18MB4734AAA106B7EDE3D80C59DCC78FA@PH0PR18MB4734.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR18MB4734AAA106B7EDE3D80C59DCC78FA@PH0PR18MB4734.namprd18.prod.outlook.com>

On Mon, Dec 11, 2023 at 02:51:19PM +0000, Shinas Rasheed wrote:
> > > > This architecture design is unlikely to work in the real world unless
> > > > you control both PF and VF environment. Mostly PF is running some old
> > > > legacy distribution while VFs run more modern OS and this check will
> > > > prevent to run new driver in VF.
> > > >
> > > > Thanks
> > >
> > > Thanks for the review. This version validation only concerns regarding the
> > >control net API layer (which is used to communicate with
> > > the firmware). In the case you have described, this instead enables new VF
> > >drivers to atleast work atop legacy PF drivers (note legacy here still
> > > refers to PF drivers which support this backward compatibility), although
> > >they might not be able to use the latest control net functionalities that they
> > > have been enabled for.
> > 
> > The question what will be in X years from now, when you will have v100?
> > Will you fallback to v0 for backward compatibility?
> > 
> > >
> > > In the absence of such a backward compatibility, VF drivers would issue
> > >control net requests which PF drivers wouldn't know, only leading to logs of
> > > incompatibility errors and erroneous usage.
> > >
> > > Also again please note that this version compatibility only concerns the
> > > control net infrastructure and API (the control plane).
> > 
> > It doesn't matter, even in best scenario, you can't guarantee that code in VM
> > actually
> > implements version Y fully and will need to check correctness per-command
> > anyway.
> > 
> > Thanks
> 
> I'm afraid as to what else can be an alternative? The control net commands have to be decoded and passed by the PF driver for the VFs,
> as only the PFs have access to talk to firmware directly. The VF drivers do not have an alternative way to query control net APIs, and may fail 
> if the control net APIs they have are not even recognized by the PF to decode them.
> 
> Either VF commands which the PF can't support can be blocked at the source (by the equivalent PF-VF backward compatibility which will exist in VF drivers)
> by this negotiation, or we have to let commands come through and fail them, leading to just redundancy in terms of running code. I don't see how this negotiation in
> any way 'limit' the VF drivers.
> 
> As you said, in essence the VF drivers will have to fallback to v0 for backward compatibility if the native host uses some old OS having older PF drivers. If not, the 
> commands would come and fail anyways at the PF. Either way, it's an error case and this negotiation is just to decide if we are going to allow letting such commands in.

I don't know what netdev maintainers will do with this code, I just
pointed to this architecture/HW troublesome design.

Thanks

> 
> Thanks for your time

