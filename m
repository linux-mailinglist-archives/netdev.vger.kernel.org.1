Return-Path: <netdev+bounces-12812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249A473900E
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213BA1C20EC5
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AE31B8F1;
	Wed, 21 Jun 2023 19:28:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2919E79
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD91C433C8;
	Wed, 21 Jun 2023 19:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687375734;
	bh=nNBZ1I8BebsDYcdo4l7gDQ1Hn5OE9c3uSHYzb0t+3XM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R26wgOabmp0CRa8IiCF15kmDjYhyerIX9rlcS/KGWpf7JjbqM40DHh3XglerBXTfD
	 lcsdb1F155VAC3lXamnR3ncSMK3wj4Qtkqn3oT1iJ1fkvTjO0OAhexosC/Q/cmGXc6
	 ODs4ADET9NYu8g7pn9WVrTfiGzZhhQy1IN+YgtGXwvVOWuGdjVnudMvaLtjHGODjUZ
	 u3HnC5OGYrqjZJqryvo2nhdpHiRjkZ6dfbapVCGwvynTIxoo8L78vt31n5DlJ34BYe
	 DnzwovjtI825qZbacdpwqmBNfzHQ1D1VAHviUSp2hisebzz6xAaZu4eNr6xlzG5gCk
	 UaSEvSt+ipjlw==
Date: Wed, 21 Jun 2023 12:28:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <emil.s.tantilov@intel.com>, <jesse.brandeburg@intel.com>,
 <sridhar.samudrala@intel.com>, <shiraz.saleem@intel.com>,
 <sindhu.devale@intel.com>, <willemb@google.com>, <decot@google.com>,
 <andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
 <simon.horman@corigine.com>, <shannon.nelson@amd.com>,
 <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v3 00/15][pull request] Introduce Intel IDPF
 driver
Message-ID: <20230621122853.08d32b8e@kernel.org>
In-Reply-To: <1bbbf0ca-4f32-ee62-5d49-b53a07e62055@intel.com>
References: <20230616231341.2885622-1-anthony.l.nguyen@intel.com>
	<20230616235651.58b9519c@kernel.org>
	<1bbbf0ca-4f32-ee62-5d49-b53a07e62055@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 12:13:06 -0700 Linga, Pavan Kumar wrote:
> Thanks for the feedback. Given the timing and type of changes requested 
> for the patches, would it be possible to accept this patch series (v3) 
> in its current form, as we continue to develop and address all the 
> feedback in followup patches?

I think you're asking to be accepted in a Linux-Staging kind of a way?
AFAIK that's historically done for companies not very familiar with
upstream development, and those completely disengaged where volunteers
pick thru the rubble/code.

