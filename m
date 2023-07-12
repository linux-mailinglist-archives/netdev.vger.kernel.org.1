Return-Path: <netdev+bounces-17256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783DB750E79
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33639281AED
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A18914F6E;
	Wed, 12 Jul 2023 16:24:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3D3214F9
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412D1C433B9;
	Wed, 12 Jul 2023 16:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689179062;
	bh=m3++tsSMUkSMghoJc11Toy2mU4toGTegF/oDVOAolHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nOwgb+twFMPD6/6pah30rlN6QR3q+0zOesG0z9XUWWdEHDm4r2kpDazUAfHQm9/YQ
	 aZJXAedKKxDIozWw45dqCpEv9Z74GLQGah9cSoknf9G39pTuRl9kL7ZBn8OFuSpGKD
	 t8ezSFzRaZEE42OVpwo328xERbN5hcdp8CLerTWoWEB6tV1X6UW9j7wgqfYZjRr/MJ
	 64LDmtVP0v9nKC7W9lOXIVHpOid4E3+jypwIeef91wTyJSoSeKMG5Rcyg4EuWzWXB+
	 gKDpyrFKySlKCdRk/Z4FUwzSUXKBQW5Sj37fh7ALJpfZ2HBf4+cfB0isp5lAQQsa6+
	 JIGFIoLprH/WQ==
Date: Wed, 12 Jul 2023 09:24:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>,
 "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH net-next] tools: ynl-gen: fix parse multi-attr enum
 attribute
Message-ID: <20230712092421.7dbc6f50@kernel.org>
In-Reply-To: <DM6PR11MB465780867DE4C45F977A06D39B36A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230711095323.121131-1-arkadiusz.kubalewski@intel.com>
	<20230711205953.346e883b@kernel.org>
	<DM6PR11MB465780867DE4C45F977A06D39B36A@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 09:47:43 +0000 Kubalewski, Arkadiusz wrote:
> >+            if 'enum' in attr_spec:
> >+                decoded = self._decode_enum(rsp, attr_spec)

To be clear - this is just a quick mock up, you'll need to change 
the arguments here, obviously. Probably to decoded and attr_spec?

