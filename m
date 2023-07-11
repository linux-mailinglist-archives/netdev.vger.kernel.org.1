Return-Path: <netdev+bounces-16952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB2774F8DA
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 22:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093FF281951
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 20:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB4D1EA87;
	Tue, 11 Jul 2023 20:14:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8222F182CD
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 20:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79250C433C9;
	Tue, 11 Jul 2023 20:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689106486;
	bh=QQ99VSEJ6m4sXmbmothGlilr6UcEysLFPY7XMiYqWYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F31+5G5q1kfmzpJ15gBHIwtHxL9nwCFFLcEOKirbusA2Twqp9jcnzJRCtb14dlq94
	 PjV0eAAjnd7Cd9joG25dBCL1xkx1chsR2rvqFGyerUkjJOXzEyr0nmjXAV93oeYoHr
	 m29+ZJu0dCzQLyaD+3cJI3ZPQ+s1BCFfnRyEIvacR8gaO/H4QBppX/wxTIlxkx38V8
	 7HPEQ/ThdwClPfg+enYIkIq7DobUatOn0MLuTyhWiICws1x6v/0LET2YeIEmf+qq8U
	 pRmOm3JmcsrKQ+leYH5bieK1ykedF2/GHCsOf/3Q+EawbagWjlfefvtjzi+sYdYbtY
	 jpvvU8v026JvA==
Date: Tue, 11 Jul 2023 13:14:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "vadfed@meta.com" <vadfed@meta.com>,
 "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "vadfed@fb.com" <vadfed@fb.com>, "Brandeburg, Jesse"
 <jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "M, Saeed" <saeedm@nvidia.com>,
 "leon@kernel.org" <leon@kernel.org>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "sj@kernel.org" <sj@kernel.org>,
 "javierm@redhat.com" <javierm@redhat.com>, "ricardo.canuelo@collabora.com"
 <ricardo.canuelo@collabora.com>, "mst@redhat.com" <mst@redhat.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "Michalik, Michal"
 <michal.michalik@intel.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "jacek.lawrynowicz@linux.intel.com"
 <jacek.lawrynowicz@linux.intel.com>, "airlied@redhat.com"
 <airlied@redhat.com>, "ogabbay@kernel.org" <ogabbay@kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "nipun.gupta@amd.com"
 <nipun.gupta@amd.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "linux@zary.sk"
 <linux@zary.sk>, "masahiroy@kernel.org" <masahiroy@kernel.org>,
 "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>, "Olech, Milena"
 <milena.olech@intel.com>, "kuniyu@amazon.com" <kuniyu@amazon.com>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>, "hkallweit1@gmail.com"
 <hkallweit1@gmail.com>, "andy.ren@getcruise.com" <andy.ren@getcruise.com>,
 "razor@blackwall.org" <razor@blackwall.org>, "idosch@nvidia.com"
 <idosch@nvidia.com>, "lucien.xin@gmail.com" <lucien.xin@gmail.com>,
 "nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>, "phil@nwl.cc"
 <phil@nwl.cc>, "claudiajkang@gmail.com" <claudiajkang@gmail.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
 <mschmidt@redhat.com>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "vadim.fedorenko@linux.dev"
 <vadim.fedorenko@linux.dev>
Subject: Re: [RFC PATCH v9 00/10] Create common DPLL configuration API
Message-ID: <20230711131443.2a4af476@kernel.org>
In-Reply-To: <DM6PR11MB4657067EE043F4DBB9D8B03B9B31A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
	<ZJq3a6rl6dnPMV17@nanopsycho>
	<DM6PR11MB4657084DDD7554663F86C1C19B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
	<ZJwWXZmZe4lQ04iK@nanopsycho>
	<DM6PR11MB4657751607C36FC711271D639B30A@DM6PR11MB4657.namprd11.prod.outlook.com>
	<ZKv1FRTXWLnLGRRS@nanopsycho>
	<DM6PR11MB46575D14FFE115546FDC9DEB9B31A@DM6PR11MB4657.namprd11.prod.outlook.com>
	<ZK1CizcqjqO1L/RQ@nanopsycho>
	<DM6PR11MB4657067EE043F4DBB9D8B03B9B31A@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 17:17:51 +0000 Kubalewski, Arkadiusz wrote:
> >I think better to add the check to pin-register so future synce pin
> >users don't have similar weird ideas. Could you please add this check?
> 
> Don't think it is way to go, and I don't think there is anything good
> with preventing device drivers from labeling their pins the way they want.

We had a long argument about how label should have a clearly defined
meaning. We're not going to rehash it on every revision. What did 
I miss :|

