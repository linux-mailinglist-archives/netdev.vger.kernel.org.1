Return-Path: <netdev+bounces-141274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A646A9BA512
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 11:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2761F219AC
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 10:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0454F1632CD;
	Sun,  3 Nov 2024 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6M74uVe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FBF1CAAC;
	Sun,  3 Nov 2024 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730629544; cv=none; b=nQZ+XGpojHbYSezK1CtRDW2j5tfwCT3yKVGEnNrji6isR00dCp7SN3s7VNwu4iA0+R9ADsHPlnWekzvHDEz/oUdWNagWaPieLSkNQyWHjgjqKMW4tNc2zd0SbAxsvir55tuh7Iz9kojwlaePFMzafP3//27rW9eehUOqWAKkNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730629544; c=relaxed/simple;
	bh=4+oDp5riCTK1E9T+awQaMakgpH6I+3uJmpa9ETSVdgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJzrRees0FvA3khgwsrRt0FO00atcY4nBue84vapn+p2oQZgU0Nd+j/iAh6ZFSh0sMTjEa7ksx/FvMLm5nPnVaVJGbTDry4t5pVV0B2mb0eepvpSg4XMP91CMlRFTzvkwV/XbSVfb2qusxkrhrCqMKEqR1t1PayW587Roh/dmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6M74uVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B70C4CECD;
	Sun,  3 Nov 2024 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730629544;
	bh=4+oDp5riCTK1E9T+awQaMakgpH6I+3uJmpa9ETSVdgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6M74uVeHPcgDfPSldZzD/JzPkNsJ1ynprUDxJNpPfrnn4b/nEuFoMXgTgNQ1hceU
	 f28LDi0Upl5La5WlmUWkLuAgrDwzcgFJjAGQR1T/cTm+Dz58dyjhjVTi7wsbfjadP8
	 3oUPlwQgNGyjOu2cr3tGS65UFV9Aef8BBKtanmCzNAjH8zvRzpCkZffC3ad65b4tZ8
	 TujvtBKZ9+PcW4IBoJgP+qIqdMVKddxOT2gXcCNfkIw0VEpQ1IjDUrcaGCmHZj8fLo
	 wYPHz8vCKhBG21AXNK3qNHwON3k8b7JFjDm6Z3VIBU1hp0KHujGrNg/Pgnu8XA6UUw
	 77Lk/wUuIQmcw==
Date: Sun, 3 Nov 2024 11:25:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: snps,dwmac: Fix "snps,kbbe"
 type
Message-ID: <uouqxrfqwziaxsq5c2gwyqmahyd2qrumr2at5vxmir5esyii5y@nnrpvwcrddcz>
References: <20241101211331.24605-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101211331.24605-2-robh@kernel.org>

On Fri, Nov 01, 2024 at 04:13:31PM -0500, Rob Herring (Arm) wrote:
> The driver and description indicate "snps,kbbe" is a boolean, not an
> uint32.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


