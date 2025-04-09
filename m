Return-Path: <netdev+bounces-180563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DD0A81B03
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 04:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD1A16A038
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07AF19882B;
	Wed,  9 Apr 2025 02:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV7nlzJx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B66286347;
	Wed,  9 Apr 2025 02:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165725; cv=none; b=s/abIeXakCGblT+03k/9MIHIcOCgleounT3n1XUrjWwOLNfFVMPjc8ffbwXnZDWiCeFXFi8TL6lwL742vw9kRswxDV4SgyH4uvX2av2317HtcUkMLz9eyLH4egeTAC/ebhdfgyFBxcwVyFmCly4zW81KfhvoER5PVMVFjLjAdGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165725; c=relaxed/simple;
	bh=nsHc/Rt6TNLhoEFYL4qlySJkBPqtCkMJvXgEWjNQsvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIzUuzxvYpoOsQ4N9t9o95KPHKoPkQP2joh02uv88RQrfZS/BDIF18seJFyNQemiDgFQ093zY+MagbHBKqhZqoy44IggMcBhD0qKnx4kMcxzlK2oviSzbO8vxvuNqdCx7hHsczMwJcXzSNr467/p6bSBqbRSy4Z32NeKzMq/Mtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV7nlzJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F77C4CEE5;
	Wed,  9 Apr 2025 02:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744165725;
	bh=nsHc/Rt6TNLhoEFYL4qlySJkBPqtCkMJvXgEWjNQsvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gV7nlzJxDf7W3wI9WoIPtsGcCqDPlaibkydPjn/90Y5yrLP1P02YMIHFTYwzj58vM
	 vwG1PYvkrulTHKrlf64JPzjEvCMoMkj42IGsCoheKyhsPUxOc4bBk54jJrvg8ruhJ7
	 CigE8r5szCBLVWvClIJcQwlIXjzQkerGK/n/GCnxVBqVcVrTVPGtpYKdHYxZXzx9sW
	 d1+mIlBK6UBDpo+SDjIBeOLxvkHqqHC0gw+3TT7UF7TYTTzvfjCEoNn8uOA4VQgABN
	 vFrUnogvPMqZsBMmXNy6rdh7jQLGjk7NJaZpw0SVizrmgIW+jZnJwna0hkqavwlf46
	 6Fs9ARkkgBYaw==
Date: Tue, 8 Apr 2025 19:28:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>, przemyslaw.kitszel@intel.com,
 jiri@resnulli.us, horms@kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, Mateusz Polchlopek
 <mateusz.polchlopek@intel.com>, Bharath R <bharath.r@intel.com>, Slawomir
 Mrozowicz <slawomirx.mrozowicz@intel.com>, Piotr Kwapulinski
 <piotr.kwapulinski@intel.com>
Subject: Re: [PATCH net-next 08/15] ixgbe: add .info_get extension specific
 for E610 devices
Message-ID: <20250408192843.0736bf09@kernel.org>
In-Reply-To: <20250407215122.609521-9-anthony.l.nguyen@intel.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
	<20250407215122.609521-9-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Apr 2025 14:51:12 -0700 Tony Nguyen wrote:
> +	err = devlink_info_version_running_put(req, "fw.mgmt.srev", ctx->buf);
> +	if (err)
> +		return err;
> +
> +	ixgbe_info_orom_srev(adapter, ctx);
> +	err = devlink_info_version_running_put(req, "fw.undi.srev", ctx->buf);

Please add a note in the documentation (the iproute2 man page, the main
devlink info one, and in the driver doc) stating that any security
versions reported via devlink are purely informational. Devlink does
not use a secure channel to communicate with the device.

