Return-Path: <netdev+bounces-188379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE2BAAC945
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 17:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2A13BDC26
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFAE2836A3;
	Tue,  6 May 2025 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dsj8nT5i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3716925DB1E
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746544834; cv=none; b=skel1yTqBprfKy405Rm1JDuGTuF4qG5l+NkWH98h5QEp3Yh5tMLUOTKhE/KkYYBBv6lEpjrmszD/KytSA4gBMInq5lMlf9754B3ckEl3GXQ09wIRbTdb6U45PeBv0TULkfvoFalYYIylyNfhOQxbHvsbecFl9Ki8N3IOigC8krc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746544834; c=relaxed/simple;
	bh=fX4WzNeGvq6RHXfZG30zx0OSVaRJPNn7KAovJwRvo50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHEt9ReEnx5sv/ptik4QEpCe9O/U9NbTpLh6K99USsQYcWNtNYWLTKNW0b7QGEbJ3fcrj33tODE90aMkYJug4/I63obXIrBMVdLiH6t2LB1EwOw2kJxfc/FitrpboxGyCjYnLLF97/td53Fdmc3bwPIdvJyqrAsyoQDWnvFSJEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dsj8nT5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29114C4CEE4;
	Tue,  6 May 2025 15:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746544833;
	bh=fX4WzNeGvq6RHXfZG30zx0OSVaRJPNn7KAovJwRvo50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dsj8nT5irN7IsWunFwZNcmpvghji+6qC4mECYHkeQ1TTPbuXGuPWo1r7Ha7rh1Top
	 BpioeBqx7JXNxgLI0RmaN/WxML8ITNnO38ATEMej5+VoRLed5Cw7xq7TVS8CK0Y3DK
	 PLiTJYSNjl6+NDgpfg+J+5U5Cz31jizQXMkGWtCheMXDI0bjjnnIh5Lp+X9AW74WRR
	 0EUhqxjIKoqa6apZnVzAURTnPTedzyXUH7to7N0pBNZo51ty4kEefuEr0oPIraNHFM
	 6rUVRMvIyUqgZ1Lq7hSHR7euXI8Z2yTJXCAGtmA6zSNRRe0lO3BJKldgDJnFdH8X4O
	 AIj3MSwEUoTQQ==
Date: Tue, 6 May 2025 08:20:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [RFC net-next 0/5] devlink: Add unique identifier to devlink
 port function
Message-ID: <20250506082032.1ab8f397@kernel.org>
In-Reply-To: <c19e7dec-7aae-449d-b454-4078c8fbd926@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
	<20250424162425.1c0b46d1@kernel.org>
	<95888476-26e8-425b-b6ae-c2576125f484@nvidia.com>
	<20250428111909.16dd7488@kernel.org>
	<507c9e1f-f31a-489c-8161-3e61ae425615@nvidia.com>
	<20250501173922.6d797778@kernel.org>
	<d5241829-bd20-4c41-9dec-d805ce5b9bcc@nvidia.com>
	<20250505115512.0fa2e186@kernel.org>
	<c19e7dec-7aae-449d-b454-4078c8fbd926@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 6 May 2025 14:25:10 +0300 Mark Bloch wrote:
> > Thanks for explaining the setup. Could you please explain the user
> > scenario now? Perhaps thinking of it as a sequence diagram would
> > be helpful, but whatever is easiest, just make it concrete.
> >  =20
>=20
> It's a rough flow, but I believe it clearly illustrates the use case
> we're targeting:
> =20
> Some system configuration info:
> =20
> - A static mapping file exists that defines the relationship between
>   a host and the corresponding ARM/DPU host that manages it.
> =20
> - OVN, OVS and Kubernetes are used to manage network connectivity and
>   resource allocation.
> =20
> Flow:
> 1. A user requests a container with networking connectivity.
> 2. Kubernetes allocates a VF on host X. An agent on the host handles VF
>    configuration and sends the PF number and VF index to the central
>    management software.

What is "central management software" here? Deployment specific or
some part of k8s?

> 3. An agent on the DPU side detects the changes made on host X. Using
>    the PF number and VF index, it identifies the corresponding
>    representor, attaches it to an OVS bridge, and allows OVN to program
>    the relevant steering rules.

What does it mean that DPU "detects it", what's the source and=20
mechanism of the notification?
Is it communicating with the central SW during  the process?=20

> This setup works well when the mapping file defines a one-to-one
> relationship between a host and a single ARM/DPU host.
> It's already supported in upstream today [1]
> =20
> However, in a slightly more generic scenario like:
> =20
> Control Host A: External host X
>                 External host Y
> =20
> A single ARM/DPU host manages multiple external hosts. In this case, step
> 2=E2=80=94where only the PF number and VF index are sent is insufficient.=
 During
> step 3, the agent on the DPU reads the data but cannot determine which
> external host created the VF. As a result, it cannot correctly associate
> the representor with the appropriate OVS bridge.
> =20
> To resolve this, we plan to modify step 2 to include the VUID along with
> the PF number and VF index. The DPU-side agent will use the VUID to match
> it with the FUID, identify the correct PF representor, and then use
> standard devlink mechanisms to locate the corresponding VF representor.
>=20
> 1: https://github.com/ovn-kubernetes/ovn-kubernetes
> You can look at: go-controller/pkg/util/dpu_annotations.go for more info.

A link to the actual file / relevant code would be more helpful :(

