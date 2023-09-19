Return-Path: <netdev+bounces-34913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14C27A5E3F
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35041C2104D
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 09:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23233FB1E;
	Tue, 19 Sep 2023 09:40:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71C3D3A0
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 09:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD7CC433C7;
	Tue, 19 Sep 2023 09:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695116401;
	bh=xUSE25r0oJ3f4NH79rN7650LsxSaeIDs03u0Ela0NkA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=B+8j6J653S7hN/P0sDXLfkZCrkXWcs/201tlLesCMKYeS27mE3L8IG2qk7AAKg+2e
	 BUNS5NZm5JBAjTmq3GDLC5ye8CNJyMrm7azjWAk6bw0E2F+XLRY4x0wrGB2V5MhQGZ
	 Ki0ZQJyaFcYSLGRFN9mojUPq91NN2dkqHVrCNogaFKSg+IjPuz9iWRlTBiZhZra0L8
	 2tygmWZJ+rUn+kQ9Qe2QrFu6h8s1oXtGd3sVDtGq9oQHu1k/JNmlsa4Ct7tWxiDVH+
	 e2yjQ23XCx79G/cwJvFmU478618R+x80XBRSqQcOjr+y9gCP5/il85H44EBc/vWHwF
	 CBum4FD6nQBdg==
From: Kalle Valo <kvalo@kernel.org>
To: Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org,  Bjorn Helgaas <helgaas@kernel.org>,  Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>,  Rob Herring <robh@kernel.org>,
  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,  Lukas Wunner
 <lukas@wunner.de>,
  "Rafael J . Wysocki" <rafael@kernel.org>,  Heiner Kallweit
 <hkallweit1@gmail.com>,  Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
  linux-kernel@vger.kernel.org,  Jeff Johnson <quic_jjohnson@quicinc.com>,
  ath10k@lists.infradead.org,  linux-wireless@vger.kernel.org,
  ath11k@lists.infradead.org,  ath12k@lists.infradead.org,
  intel-wired-lan@lists.osuosl.org,  linux-arm-kernel@lists.infradead.org,
  linux-bluetooth@vger.kernel.org,  linux-mediatek@lists.infradead.org,
  linux-rdma@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH v2 09/13] wifi: ath10k: Use pci_disable/enable_link_state()
References: <20230918131103.24119-1-ilpo.jarvinen@linux.intel.com>
	<20230918131103.24119-10-ilpo.jarvinen@linux.intel.com>
Date: Tue, 19 Sep 2023 12:39:54 +0300
In-Reply-To: <20230918131103.24119-10-ilpo.jarvinen@linux.intel.com> ("Ilpo
	=?utf-8?Q?J=C3=A4rvinen=22's?= message of "Mon, 18 Sep 2023 16:10:59
 +0300")
Message-ID: <87msxibixh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:

> ath10k driver adjusts ASPM state itself which leaves ASPM service
> driver in PCI core unaware of the link state changes the driver
> implemented.
>
> Call pci_disable_link_state() and pci_enable_link_state() instead of
> adjusting ASPMC field in LNKCTL directly in the driver and let PCI core
> handle the ASPM state management.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

