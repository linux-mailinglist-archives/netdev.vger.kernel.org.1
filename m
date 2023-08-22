Return-Path: <netdev+bounces-29529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79054783A77
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B93280FF8
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F09B7468;
	Tue, 22 Aug 2023 07:11:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31598746B
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C08C43140;
	Tue, 22 Aug 2023 07:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1692688268;
	bh=OSFmIc6DjVqzpF68MG32L32Nfk/PkwF+T/iEcUfE7zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yFhT1h6G7GQs4G8xdXWO83os1xmaegpIyyVgziAzY/RjT4jaPabj1XFXBMGL/iE0W
	 IHtR6aNZw4QOeK7FZqjtRLpC+fVw62vbtkU06cUtNIRZiBgB1yiGvLyyej+vglfWid
	 24ydufv4IeSFNst1ft204xjSah4Qbu3Wjk6I543w=
Date: Tue, 22 Aug 2023 08:39:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: Evan Quan <evan.quan@amd.com>, Andrew Lunn <andrew@lunn.ch>,
	rafael@kernel.org, lenb@kernel.org, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alexander.deucher@amd.com, rdunlap@infradead.org,
	quic_jjohnson@quicinc.com, horms@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [V9 1/9] drivers core: Add support for Wifi band RF mitigations
Message-ID: <2023082247-synthesis-revenge-470d@gregkh>
References: <20230818032619.3341234-1-evan.quan@amd.com>
 <20230818032619.3341234-2-evan.quan@amd.com>
 <2023081806-rounding-distract-b695@gregkh>
 <2328cf53-849d-46a1-87e6-436e3a1f5fd8@amd.com>
 <2023081919-mockup-bootleg-bdb9@gregkh>
 <e5d153ed-df8a-4d6f-8222-18dfd97f6371@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d153ed-df8a-4d6f-8222-18dfd97f6371@amd.com>

On Mon, Aug 21, 2023 at 10:13:45PM -0500, Limonciello, Mario wrote:
> So I wonder if the right answer is to put it in drivers/net/wireless
> initially and if we come up with a need later for non wifi producers we can
> discuss moving it at that time.

Please do so.

thanks,

greg k-h

