Return-Path: <netdev+bounces-184718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8910BA96FD9
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D0C1B66537
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69FF27BF7D;
	Tue, 22 Apr 2025 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRWmgWcJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8273635949
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745334161; cv=none; b=fkJdJH/MvpAc1TQYM+l9K3Jk97C5YqNbR3ttfCbl1JwUCy9cMRUnuz88xDHMY6c2vLoG34GjZmpOlUyKOtduECN0UheXMU8RRrzuR+C1yusBbG5wWfyDW/emoaPBib6RWMLVzD7RT+ZFxyVDBF96ZNBVEnFWJGvLMFpUzNUNy0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745334161; c=relaxed/simple;
	bh=631ooWU/IIBWbibqv5uQh9Dw6r3rFg9c6eQU86XEoJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nc3pBn4viIetU+GIwTw2gPmzVUh5iaXw7CAdr9HKqEdf1ETHDI8bneB7PpMYfOamNy+1gsYwZ0wKr20INAaMymLUhxT7zbjdSpI9kh+S3HdW2BwuJQYqX/MTJvl5rtS/vcjwRXqrMrKNDhUIsTzio1zHaadeyivNEUlDCpk+/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRWmgWcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF61C4CEE9;
	Tue, 22 Apr 2025 15:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745334159;
	bh=631ooWU/IIBWbibqv5uQh9Dw6r3rFg9c6eQU86XEoJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QRWmgWcJHMTdp8zbGmuiGl+gg+O/M1MB7N7ylgotvn4++phTEYxnLtfgehAy+wi7d
	 6U3S0Nq2/yIyCWMxjkJftIYJWGQtu7t/PDQrW03V1mecosbPDUTjU9gXIX9eBdDsSM
	 sR3/UWBTnekOwArZxcJGB4frDvwSHo2nvfzXkP2oJx7Qv/9wSPxgkh8Ucb8HP7nzun
	 vfgnNBcFG751PwkFZtFtYzqprHg/b8VUAu+VgCAxm1fRwXnOxXuOUJMgyEmlfy3Eva
	 kperAaFV5tyOchhkqiXRzXk+PIpV8eabwgBBZzXoQaR+fHwdeBckWS0+7X9IxMbol1
	 t9a3xpYTK0mCw==
Date: Tue, 22 Apr 2025 08:02:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 horms@kernel.org, donald.hunter@gmail.com,
 kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] devlink: add function unique identifier
 to devlink dev info
Message-ID: <20250422080238.00cbc3dc@kernel.org>
In-Reply-To: <5abwoi3oh3jy7y65kybk42stfeu3a7bx4smx4bc5iueivusflj@qkttnjzlqzbl>
References: <20250416214133.10582-1-jiri@resnulli.us>
	<20250416214133.10582-3-jiri@resnulli.us>
	<20250417183822.4c72fc8e@kernel.org>
	<o47ap7uhadqrsxpo5uxwv5r2x5uk5zvqrlz36lczake4yvlsat@xx2wmz6rlohi>
	<20250418172015.7176c3c0@kernel.org>
	<5abwoi3oh3jy7y65kybk42stfeu3a7bx4smx4bc5iueivusflj@qkttnjzlqzbl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 11:18:23 +0200 Jiri Pirko wrote:
> Sat, Apr 19, 2025 at 02:20:15AM +0200, kuba@kernel.org wrote:
> >On Fri, 18 Apr 2025 12:15:01 +0200 Jiri Pirko wrote:  
> >> Ports does not look suitable to me. In case of a function with multiple
> >> physical ports, would the same id be listed for multiple ports? What
> >> about representors?  
> >
> >You're stuck in nVidia thinking. PF port != Ethernet port.
> >I said PF port.  
> 
> PF port representor represents the eswitch side of the link to the
> actual PF. The PF may or may not be on the same host.
> 
> Ethernet port is physical port.
> 
> Why this is nVidia thinking? How others understand it?

Because you don't have a PF port for local PF.

The information you want to convey is which of the PF ports is "local".
I believe we discussed this >5 years ago when I was trying to solve
this exact problem for the NFP.

The topology information belongs on the ports, not the main instance.

> >> This is a function propertly, therefore it makes sense to me to put it
> >> on devlink instance as devlink instance represents the function.
> >> 
> >> Another patchset that is most probably follow-up on this by one of my
> >> colleagues will introduce fuid propertly on "devlink port function".
> >> By that and the info exposed by this patch, you would be able to identify
> >> which representor relates to which function cross-hosts. I think that
> >> your question is actually aiming at this, isn't it?  
> >
> >Maybe it's time to pay off some technical debt instead of solving all
> >problems with yet another layer of new attributes :(  
> 
> What do you mean by this? 

I keep saying that the devlink instance should represent the chip /
data processing pipeline.

> We need a way to identify port representor
> (PF/VF/SF, does not matter which) and the other side of the wire that
> may be on a different host. How else do you imagine to do the
> identification of these 2 sides?

