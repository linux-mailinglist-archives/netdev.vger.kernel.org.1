Return-Path: <netdev+bounces-204184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11658AF9619
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 995C57AC382
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACBB1A83F9;
	Fri,  4 Jul 2025 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGJ3O1NC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651D382C60
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751640969; cv=none; b=n9QWEQPqnb3qgB+xiyULtPLkAM7qO2JNszNB8TAmmJGDuaa3BqA615BZYACAYOeQXyFEBho6d8WGeR2GRM6PW5CgCuYiTjiJOfdaIkRm9s6b5SzfmADVJuoySs8mj7k22TlMHBe0Ls3of0m6z7oC8/1G7RAZurF6kSTjQT/VwkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751640969; c=relaxed/simple;
	bh=wUe1tVAHYsVRseV1SJHF2HIemjtOqk7S/dvCijh60G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZH/M0Qr0XcyYEhphp4XONcwE/mWQXm/3P4s04FxnU31i1U59Lc7MKwXa6yj5suJUEafokU/0q5IfyIfjOrvAoU14gXUkw5quH5huN8XMR0lXy2DyFBN0y7oA2E9/nRkEmEVH9bQFtHIY/pmfX8ln2ghVj40hPnjkPsuhRud3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGJ3O1NC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EB5C4CEE3;
	Fri,  4 Jul 2025 14:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751640968;
	bh=wUe1tVAHYsVRseV1SJHF2HIemjtOqk7S/dvCijh60G8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGJ3O1NCJMPg5dnuVN/zqoFOgMns+rl4jUZc+UNbXHrrz9npKf1O8QyxyVf5iloKG
	 c4JajbJuXqEsL+1p2cqfv4ConEiPImRiPQPLVG4xua62g+F7+bW3nOG2UaUQqTh9Xn
	 rkXnefrEoj2QFS34DqK9Rw97pP1tsP9z1/vhR5ZNK4SEDj584PeU3dKI0VxVGQjSLC
	 ughOBVG/UYns4sBDANtdSg4oqV0SuyrM/HOPY6ohrMr+LQT0AP2PxxCXmKjxXEdtKi
	 k3PQuwiOun2z/LwRrtcus0ZXYr9UCQgxjirtH5Y8M6khfITF0Xx+f4RNmmpPQfsFgc
	 Cu6g752/2s58w==
Date: Fri, 4 Jul 2025 15:56:04 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 4/6] net: airoha: npu: Read NPU interrupt lines
 from the DTS
Message-ID: <20250704145604.GD41770@horms.kernel.org>
References: <20250702-airoha-en7581-wlan-offlaod-v1-0-803009700b38@kernel.org>
 <20250702-airoha-en7581-wlan-offlaod-v1-4-803009700b38@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-airoha-en7581-wlan-offlaod-v1-4-803009700b38@kernel.org>

On Wed, Jul 02, 2025 at 12:23:33AM +0200, Lorenzo Bianconi wrote:
> Read all NPU supported IRQ lines from NPU device-tree node.
> This is a preliminary patch to enable wlan flowtable offload for EN7581
> SoC.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Lorenzo,

I think a bit more information is needed on how you plan to use this.
Ideally in the form of a patch that does so.

