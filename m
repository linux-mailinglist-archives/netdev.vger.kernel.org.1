Return-Path: <netdev+bounces-218419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 846A0B3C5C0
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 01:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D558E1C878F4
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 23:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC576273D92;
	Fri, 29 Aug 2025 23:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4sVsBcv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806EE481B1;
	Fri, 29 Aug 2025 23:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511800; cv=none; b=T37ojdNuDEcB6EZlP7C/QrNmH2BqDT3ag0Rstc6GdG1Cf7gl1SjvubHko9dgYCu+KI//4l0ktZerWYjhEt4PumyFi1Jixwg8y/ej4vDiCLlll6kZov8QPywxniBzEFH83heT9dwCuzJanb9YnnQVcAy4l60ZViqSwd2e9rxx2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511800; c=relaxed/simple;
	bh=ouc/bJmp7GXyTRNlmBqsUP2nU3STV9Zvh8kLahwbmfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HninschpC0R38pf5zBQKanN7r5gBhdstRSjHi6J6AdtV1R96j0kfUgqDg76GMThZF1PAHy6VPkYUOsO/N/1gsyLBCEJoKtT9qSEsjl2MDI3Fpg+4uv/keC0XjxjKpst+HC+Tfzlv1oI54F+LWXtSSTNuHYp5tnb5S0eJ8T+JRWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4sVsBcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6BCC4CEF0;
	Fri, 29 Aug 2025 23:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756511800;
	bh=ouc/bJmp7GXyTRNlmBqsUP2nU3STV9Zvh8kLahwbmfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y4sVsBcvMQNw26wmpHHwYytfQCRXoygGXfFOU4hEsvfIXL9HU4QnS4tOelriL4p+3
	 BGVAZdeG+YtrHnD0XU9uHP6eQQ/NpxBJGQGefa8Eswa93hdHbrC7vpwZQFqKeVzrHt
	 pJ8z0VJa/MEcGFG0ijaA5Y+P+HaOs9DmAjeKnyFpLqFvMOGJvTmaRqir3nJmRHJIKH
	 HqErAVYw3m/F2yhdS5ToVL2sJFWAAuFYxXDr6PYQ+V7jH8vOSNTJ13bFf6mAnzfWAS
	 tUtw4y/x8YGejtQi0fnFJ4fIj/edbqFSmRDLN+5b9ot+3wv8CNbuODw2Rhq3IrSx66
	 FnE2u1l/6iZ/A==
Date: Fri, 29 Aug 2025 16:56:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Schmidt
 <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v3 5/5] dpll: zl3073x: Implement devlink flash
 callback
Message-ID: <20250829165638.3b50ea2a@kernel.org>
In-Reply-To: <e7a5ee37-993a-4bba-b69e-6c8a7c942af8@redhat.com>
References: <20250813174408.1146717-1-ivecera@redhat.com>
	<20250813174408.1146717-6-ivecera@redhat.com>
	<20250818192943.342ad511@kernel.org>
	<e7a5ee37-993a-4bba-b69e-6c8a7c942af8@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 16:49:22 +0200 Ivan Vecera wrote:
> >> +		/* Leave flashing mode */
> >> +		zl3073x_flash_mode_leave(zldev, extack);
> >> +	}
> >> +
> >> +	/* Restart normal operation */
> >> +	rc = zl3073x_dev_start(zldev, true);
> >> +	if (rc)
> >> +		dev_warn(zldev->dev, "Failed to re-start normal operation\n");  
> > 
> > And also we can't really cleanly handle the failure case.
> > 
> > This is why I was speculating about implementing the down/up portion
> > in the devlink core. Add a flag that the driver requires reload_down
> > to be called before the flashing operation, and reload_up after.
> > This way not only core handles some of the error handling, but also
> > it can mark the device as reload_failed if things go sideways, which
> > is a nicer way to surface this sort of permanent error state.  
> 
> This makes sense... The question is if this should reuse existing
> .reload_down and .reload_up callbacks let's say with new devlink action
> DEVLINK_RELOAD_ACTION_FW_UPDATE or rather introduce new callbacks
> .flash_update_down/_up() to avoid confusions.

Whatever makes sense for your driver, for now. I'm assuming both ops
are the same, otherwise you wouldn't be asking? It should be trivial
for someone add the extra ops later, and just hook them both up to the
same functions in existing drivers.

