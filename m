Return-Path: <netdev+bounces-57009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03668118FF
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AA9281D0E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CFB3309D;
	Wed, 13 Dec 2023 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO0UVJpy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF533095
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 16:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B37C433C8;
	Wed, 13 Dec 2023 16:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702484299;
	bh=nofDktrAzxmJLGeuSB+Bw/655A8U65swg+46T2TUB+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AO0UVJpyl93I+PxZ+IL8ejygocRqAa2op9I4x3jsB1ZqwtFJRrc+bgQS9Q1/xNBCa
	 rcGaMjVTdz0wHQynlepKWsWiRutBEkoI1yVhRDYW3xha1BKL2tdncwmfnoKn3qYZ4t
	 vxWmmBpcnJX2Hr9dztBX5agWO/EER5ZKm7iyhdt7kINWFCR6zEcNLD8mL5MWLceXZ+
	 sufu9Cuw+X/SXjrWGayXnafUfTR8E34gnuBx5JefAYYuDNZ+xwSyNW82DyAtHfG4II
	 ZANGPtz6qJ2xhxLUiB4hb3D9Ey2uqOmODz3ZStR+riBy9dmEVldLUu1aLI1c295hJ2
	 /913zuUIS46+w==
Date: Wed, 13 Dec 2023 08:18:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [Draft PATCH net-next 1/3] Documentation: netlink: add a YAML
 spec for team
Message-ID: <20231213081818.4e885817@kernel.org>
In-Reply-To: <20231213084502.4042718-2-liuhangbin@gmail.com>
References: <20231213084502.4042718-1-liuhangbin@gmail.com>
	<20231213084502.4042718-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 16:45:00 +0800 Hangbin Liu wrote:
> +    -
> +      name: noop
> +      doc: No operation
> +      value: 0
> +      attribute-set: team
> +      dont-validate: [ strict, dump ]
> +
> +      do:
> +        # Actually it only reply the team netlink family
> +        reply:
> +          attributes:
> +            - team-ifindex

Oh my. Does it actually take team-ifindex or its an op with no input
and no output?

