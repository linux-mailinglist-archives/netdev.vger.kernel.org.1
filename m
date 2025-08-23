Return-Path: <netdev+bounces-216242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50AAB32B92
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 21:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A893B5E37
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 19:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1124F1E32A2;
	Sat, 23 Aug 2025 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JVsMms9v"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9163CC2E0;
	Sat, 23 Aug 2025 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755975948; cv=none; b=YJGi1GZW50AgbNV1OHjjv2KHHQInutob8BmfPd+4WlaBqz6gsJEK36QX+Dc9iPSF9F2YC6XnY5yv1/ogQ4HSI9RB2bhO+LdII3cR0b4XEr93k1Nok1/URL8DBGFsv98gTjksy6i3No3vQvJfes+YBX5HFb3VST8tFcQyJQoiu84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755975948; c=relaxed/simple;
	bh=HADGWc/8c7Ue8Uu3E7Lyc54Gu7V9kKuSTwgz8aZ+ytw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SipaViIn/Fp2f538YsL+6qyjzKJIg//b+pA8zRwA/TO+3x1XH7uvAcTvjv+fNB/zEQqTsSld5FpMAVjsfESnhSsFxwenYv/afzDVxFP5QHFD0zNjK/1mXfdKKdy0TNiL2n+IQ+Vb2Ah1HlYnXHS+cdze5ZK/XLsT68tSxbrtDsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JVsMms9v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1jwY+cXkjW78wASvzBMdo6/QjyjEvwPV1COyCXN2B4U=; b=JVsMms9vlTxqZbzMveaKok7A7x
	xGR9PSM4ARRmpouPIwQh0vMfBbYMQKZrPLhwK3pzY3HRhGShdyvJbin/fJJ5GgTHkkthpZsvq75wq
	L4barOGQ/qjgQGSHMspBUC/LJyYXlZbs41ZN62j1WqCXfePL3Bs64ldYsPME/dAGhMTs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uptYW-005mD9-DH; Sat, 23 Aug 2025 21:05:36 +0200
Date: Sat, 23 Aug 2025 21:05:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: Re: [PATCH v3 net-next 2/5] net: fec: add pagepool_order to support
 variable page size
Message-ID: <c7a79697-1dd1-4c01-a7a3-2223746dd964@lunn.ch>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
 <20250823190110.1186960-3-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823190110.1186960-3-shenwei.wang@nxp.com>

On Sat, Aug 23, 2025 at 02:01:07PM -0500, Shenwei Wang wrote:
> Add a new pagepool_order member in the fec_enet_private struct
> to allow dynamic configuration of page size for an instance. This
> change clears the hardcoded page size assumptions.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

