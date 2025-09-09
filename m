Return-Path: <netdev+bounces-221319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DC0B50241
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3F43BE988
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C212F350D52;
	Tue,  9 Sep 2025 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZyAsOxYQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DA1352066;
	Tue,  9 Sep 2025 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434530; cv=none; b=ieS62G62nQw3Z1BGAMz3vdUqMqhxkcxT5rn/9V9gAKPmJOQWc5dElT2v1cB4szlkdGfRgmNqMBWWCjE4RmAf+dyxFD363H8yBbb2Ikfy1khzaFM0N17SX1A4tgZjsGZbz1INr41W3bdkVwlXdNouG/ZWREqm+2bLx0EhEGeNyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434530; c=relaxed/simple;
	bh=RorEK3O6/RGxuCSl8FL3e05A6VzWmRbt9LXl7Ut6ios=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a16DWMhqUPHp8mCwN7r2KVDzydadLBL7ah068XZR84+dZXRLXvqhNVevcge6jNVO2VXcCxuh7T3Doi2xOkKHyWvToMb8BS6qCQ3gM8LPmNhkxrhu5JfRnNVwPKYm0AAK0sDAC/EwiXDxIVpqOWJ8W4xwblxedT4U4U1D8h9HkUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZyAsOxYQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d0dwwpU1Qlk6W/MV9O8vOzG5HrwlT2N/gNRXS0VisPQ=; b=ZyAsOxYQf43Wp1nJZyMBUJqfxg
	rxMZqNJl5h7iarHJRhbhjh7dF6v+nhskTUBg0MCmPHrsRMfpX4LFMkrIDbR4HX6vZqGN8mCC3g8ee
	cdKGyzWWL5DQlVJLID/EaTaaBeu7fzpeLoZ3PO5djJFHRGBPBTW5I+8EtP+NmG5d8/rU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uw106-007ov6-1j; Tue, 09 Sep 2025 18:15:22 +0200
Date: Tue, 9 Sep 2025 18:15:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] geneve: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <feff0872-567c-48fc-b7e4-c7d11a782c64@lunn.ch>
References: <aMBK78xT2fUnpwE5@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMBK78xT2fUnpwE5@kspp>

On Tue, Sep 09, 2025 at 05:42:39PM +0200, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the corresponding
> structure. Notice that `struct ip_tunnel_info` is a flexible
> structure, this is a structure that contains a flexible-array
> member.
> 
> Fix the following warning:
> 
> drivers/net/geneve.c:56:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

