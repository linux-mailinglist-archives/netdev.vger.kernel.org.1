Return-Path: <netdev+bounces-139175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081D39B0A89
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 19:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1FB28136C
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3529C18C039;
	Fri, 25 Oct 2024 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNQjSnzn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C78F1862AE;
	Fri, 25 Oct 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876024; cv=none; b=QHmbVr/ZbuQtmUmd1KPYZLuNP2IqkTCkiG0qrnxWXKj5V3Jh207BUoguhC+2OTaXaIz3QsKLnsOUFf4lXNq7WqqgCXbZpxoz6yCfXlfGwVTOABfArkU0NaF/9SlSLfmUfCfuR82QBcXY0z/IBtQvb4VqsuGO5/QfPvIzfRsElkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876024; c=relaxed/simple;
	bh=JD3au4w/jb4VjNY1ylI9zqqEX9kXTpATWVFuGCg6nwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuLHwHXWlsdPjwJbjH3LrPfXgXFALtSktzhBtT08O1Q93tdMNkuF+Sj39yeRYI/4+c5cHyLIbKmvyyDa3HBfQiRQ0N6/Yb18DW5skAkQZKkqymS9BBWTYq0xjaq57dn8z2NzOaMM1vyABjvlQCKbngAUSx8tMp9OcIeCLlvGXyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNQjSnzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679DFC4CEE4;
	Fri, 25 Oct 2024 17:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729876023;
	bh=JD3au4w/jb4VjNY1ylI9zqqEX9kXTpATWVFuGCg6nwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNQjSnznBSjiWLwwV7faCJ3W/3rgsSVLF+BsQqx3E7uoH6bw++JTrJKY5M7aHsRmd
	 2oZuYf3Rm8/l2fKQ/B8dDcO+76HLBynkmONZw0kqER7JIuw2mdD31DvVlcfy0WsqzV
	 VkOqHaHSgXGnciSW1UUeCVS6xSlKkIYIb9qZLl6OPXiEVJtnJmpSkVAW2xDAsrgQEK
	 +4DqWMn/d0zXaHLrKssqdeyits5M1hVw0m9CEKYhxz5+CdAV/v4ZpunqJLt7a0ydX2
	 Vg1ndjCU/z+tAydhwnT4kDm5mBxBXIhyaZkztSgBqYl6omM9+AgZZkwQBd0cZrMp5f
	 3cexuT8X/GuCg==
Date: Fri, 25 Oct 2024 13:07:01 -0400
From: Sasha Levin <sashal@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kees@kernel.org, broonie@kernel.org
Subject: Re: [GIT PULL] Networking for v6.12-rc5
Message-ID: <ZxvQNdnKWMQLN6l2@sashalap>
References: <20241024140101.24610-1-pabeni@redhat.com>
 <ZxpZcz3jZv2wokh8@sashalap>
 <87cyjpj6qx.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cyjpj6qx.fsf@mail.lhotse>

[snip]

I ran the current state of the scripts on the delta between Linus's
master and linus-next. It is pasted below.

The number of patches that haven't been in -next in this random sample
is indeed worrysome (and provides a good justification to the
(unrelated) linus-next effort).

As a reminder, the scripts are available at
https://git.kernel.org/pub/scm/linux/kernel/git/sashal/next-analysis.git/
, and I'm happy to help with issues around them.

To avoid getting on everyone's nerves, I don't plan on bringing these up
again in the context of random PRs unless asked to do so by the relevant
maintainers/Linus.



Days in linux-next:
----------------------------------------
  0 | ██████████████████████████████████████████████████ (32)
<1 | ████ (3)
  1 | ████ (3)
  2 | ████████████ (8)
  3 | ███████████████ (10)
  4 | ███████████████ (10)
  5 | 
  6 | 
  7 | 
  8 | ███ (2)
  9 | ██████ (4)
10 | █ (1)
11 | ███████ (5)
12 | 
13 | 
14+| █████████████████ (11)

Commits with 0 days in linux-next (35 of 89: 39.3%):
--------------------------------
d34a5575e6d23 fuse: remove stray debug line
  fs/fuse/passthrough.c | 1 -
  1 file changed, 1 deletion(-)

cdc21021f0351 drm/xe: Don't restart parallel queues multiple times on GT reset
  drivers/gpu/drm/xe/xe_guc_submit.c | 14 ++++++++++++--
  1 file changed, 12 insertions(+), 2 deletions(-)

9c1813b325348 drm/xe/ufence: Prefetch ufence addr to catch bogus address
  drivers/gpu/drm/xe/xe_sync.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

69418db678567 drm/xe: Handle unreliable MMIO reads during forcewake
  drivers/gpu/drm/xe/xe_force_wake.c | 12 +++++++++---
  1 file changed, 9 insertions(+), 3 deletions(-)

22ef43c78647d drm/xe/guc/ct: Flush g2h worker in case of g2h response timeout
  drivers/gpu/drm/xe/xe_guc_ct.c | 18 ++++++++++++++++++
  1 file changed, 18 insertions(+)

c8fb95e7a5431 drm/xe: Enlarge the invalidation timeout from 150 to 500
  drivers/gpu/drm/xe/xe_device.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

d93df29bdab13 cpufreq: CPPC: fix perf_to_khz/khz_to_perf conversion exception
  drivers/acpi/cppc_acpi.c | 22 +++++++++++++++++-----
  1 file changed, 17 insertions(+), 5 deletions(-)

3d1c651272cf1 ACPI: PRM: Clean up guid type in struct prm_handler_info
  drivers/acpi/prmt.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

8e59a2a5459fd ata: libata: Set DID_TIME_OUT for commands that actually timed out
  drivers/ata/libata-eh.c | 1 +
  1 file changed, 1 insertion(+)

7c210ca5a2d72 drm/amdgpu: handle default profile on on devices without fullscreen 3D
  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 11 ++++++++++-
  1 file changed, 10 insertions(+), 1 deletion(-)

ba1959f71117b drm/amd/display: Disable PSR-SU on Parade 08-01 TCON too
  drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 ++
  1 file changed, 2 insertions(+)

108bc59fe8176 drm/amdgpu: fix random data corruption for sdma 7
  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 9 ++++++++-
  1 file changed, 8 insertions(+), 1 deletion(-)

63feb35cd2655 drm/amd/display: temp w/a for DP Link Layer compliance
  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 13 +++++++++++++
  1 file changed, 13 insertions(+)

23d16ede33a4d drm/amd/display: temp w/a for dGPU to enter idle optimizations
  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

f67644b219d45 drm/amd/pm: update deep sleep status on smu v14.0.2/3
  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 7 ++++++-
  1 file changed, 6 insertions(+), 1 deletion(-)

f888e3d34b864 drm/amd/pm: update overdrive function on smu v14.0.2/3
  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

9515e74d756b6 drm/amd/pm: update the driver-fw interface file for smu v14.0.2/3
  drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h                     |   2 +-
  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c             |  57 +++++++++++++-----------------------------
  3 files changed, 102 insertions(+), 89 deletions(-)

bf58f03931fdc drm/amd: Guard against bad data for ATIF ACPI method
  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 15 ++++++++++++---
  1 file changed, 12 insertions(+), 3 deletions(-)

d719fecdc2d6d media: i2c: tc358743: export InfoFrames to debugfs
  drivers/media/i2c/tc358743.c | 36 +++++++++++++++++++++++++++++++++++-
  1 file changed, 35 insertions(+), 1 deletion(-)

be3aeece83e23 media: i2c: adv7842: export InfoFrames to debugfs
  drivers/media/i2c/adv7842.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------
  1 file changed, 88 insertions(+), 32 deletions(-)

6703538b8b6f8 media: i2c: adv7604: export InfoFrames to debugfs
  drivers/media/i2c/adv7604.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------
  1 file changed, 70 insertions(+), 20 deletions(-)

b0644b12f2579 media: i2c: adv7511-v4l2: export InfoFrames to debugfs
  drivers/media/i2c/adv7511-v4l2.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
  1 file changed, 74 insertions(+), 17 deletions(-)

155043e173660 media: v4l2-core: add v4l2_debugfs_if_alloc/free()
  drivers/media/v4l2-core/v4l2-dv-timings.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  include/media/v4l2-dv-timings.h           | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 115 insertions(+)

e24486d0c6992 media: v4l2-core: add v4l2_debugfs_root()
  drivers/media/v4l2-core/v4l2-dev.c | 14 ++++++++++++++
  include/media/v4l2-dev.h           | 15 +++++++++++++++
  2 files changed, 29 insertions(+)

3d882f3a391db media: vb2: use lock if wait_prepare/finish are NULL
  drivers/media/common/videobuf2/videobuf2-core.c | 13 ++++++++++---
  1 file changed, 10 insertions(+), 3 deletions(-)

aea26177c7175 media: vb2: vb2_core_queue_init(): sanity check lock and wait_prepare/finish
  drivers/media/common/videobuf2/videobuf2-core.c | 8 ++++++++
  1 file changed, 8 insertions(+)

22122f2094934 media: video-i2c: set lock before calling vb2_queue_init()
  drivers/media/i2c/video-i2c.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

b251fe7db1cde media: rcar_drif.c: set lock before calling vb2_queue_init()
  drivers/media/platform/renesas/rcar_drif.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

89795432ae06a media: airspy: set lock before calling vb2_queue_init()
  drivers/media/usb/airspy/airspy.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

734f583127067 media: hackrf: set lock before calling vb2_queue_init()
  drivers/media/usb/hackrf/hackrf.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

cc123e96b0c44 media: msi2500: set lock before calling vb2_queue_init()
  drivers/media/usb/msi2500/msi2500.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

8d7d72a400c43 media: pwc: set lock before calling vb2_queue_init()
  drivers/media/usb/pwc/pwc-if.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

38b1ea00360b9 media: venus: add missing wait_prepare/finish ops
  drivers/media/platform/qcom/venus/vdec.c | 2 ++
  drivers/media/platform/qcom/venus/venc.c | 2 ++
  2 files changed, 4 insertions(+)

fc3c6515678bf media: pisp_be: add missing wait_prepare/finish ops
  drivers/media/platform/raspberrypi/pisp_be/pisp_be.c | 2 ++
  1 file changed, 2 insertions(+)

8ebcb4796639e media: omap3isp: add missing wait_prepare/finish ops
  drivers/media/platform/ti/omap3isp/ispvideo.c | 18 ++++++++++++++++++
  1 file changed, 18 insertions(+)


Commits not found on lore.kernel.org/all (4 of 89: 4%):
----------------------------------------
d34a5575e6d23 fuse: remove stray debug line
e3ea2757c312e ALSA: hda/realtek: Update default depop procedure
f888e3d34b864 drm/amd/pm: update overdrive function on smu v14.0.2/3
155043e173660 media: v4l2-core: add v4l2_debugfs_if_alloc/free()

-- 
Thanks,
Sasha

