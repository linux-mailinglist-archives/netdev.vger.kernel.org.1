Return-Path: <netdev+bounces-280795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN3GAd5K6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:37:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8C0454FFE
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B39023026C1A
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4342737BE78;
	Thu, 23 Apr 2026 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPWle9fg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C231FBEBC
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961765; cv=none; b=Q7gVLcDQetd2zzHobWR+t/LzjO3jN+SbR/VTfXPFC47G7Y1FW2ltkWDgwjfyEdfG4GIYOIZGy7cjBxWz3BRrzu0iSAXSnBy3qhzN6gmoiOONQlSyaEvRfIjU9etHC4ca0ipLUe0E0uSz8WgmpFTmCn7jNLvMqIUVAEM7g6nnu6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961765; c=relaxed/simple;
	bh=1dP9r6KsChftBuI2JpeBlTGZwoiAP3vqscR1wZR1+t8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Az/y46M8ODhprGZxf56AGQFc7uiWAo6z+nJn338p8C9Vc4ClwHlMF4edkXp1pboDcMuiuWrQITagOq98eF1AoIXXugbJErlJkdURgiGrniwJJKY05dxDpJbWOy+rczgNsaXRZ/485fPTwcUihE7ikXTPHKB5in6tg+x2DL6Xy/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPWle9fg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEE7C2BCAF;
	Thu, 23 Apr 2026 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776961764;
	bh=1dP9r6KsChftBuI2JpeBlTGZwoiAP3vqscR1wZR1+t8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XPWle9fg+rCRf4fF10a5hmPtRkHDlPtsJk0d2bKNI3S/eU3sMeys6exToKvbxp3hv
	 l//Xrk5c+s28itVvpa0KD1DMBbnc9y3EuW0MKA2HUey+bLMd/UGRX8j003VF8jZDPA
	 X6xR6MAnFR2sa76Vq/VWl4y+xhPtAcrimXWxVvD/oO3nCeFI5AmD55cu1XzEcWzNe5
	 KFGlkQ8mI0imyo72pzgze1PAsGMAvnJR1NdjFUmy1XmZESypiGmVdLDojdV/QvQk2O
	 rEYfOwCFwAOcQNLH26jMxw0zZjUzJmpsCjmVl1sqMrsWrbvAmKqr9EBTQjkduHeUz3
	 tq1LKhFX6jRwg==
Date: Thu, 23 Apr 2026 09:29:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, <aravind.iddamsetty@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <anshuman.gupta@intel.com>,
 <joonas.lahtinen@linux.intel.com>, <simona.vetter@ffwll.ch>,
 <airlied@gmail.com>, <pratik.bari@intel.com>,
 <joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
 <shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
 <anvesh.bakwad@intel.com>, <maarten.lankhorst@linux.intel.com>, Zack
 McKevitt <zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar
 <lijo.lazar@amd.com>, "Hawking Zhang" <Hawking.Zhang@amd.com>, "David S.
 Miller" <davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH 3/4] drm/drm_ras: Add DRM RAS netlink error event
 notification
Message-ID: <20260423092922.6c527d75@kernel.org>
In-Reply-To: <65c6839f-a92d-4122-b347-a1250dde961d@intel.com>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
	<20260311102913.3387468-9-riana.tauro@intel.com>
	<acPjxf5XTYuR7sbM@black.igk.intel.com>
	<09f253b3-ee64-4fbb-8cec-820e9769aa80@intel.com>
	<adc6hTz-xMopiJsc@black.igk.intel.com>
	<69c061b4-eb40-4e2d-aeaa-5dfa47b2db8c@intel.com>
	<65c6839f-a92d-4122-b347-a1250dde961d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,lists.freedesktop.org,vger.kernel.org,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com];
	TAGGED_FROM(0.00)[bounces-280795-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B8C0454FFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 23 Apr 2026 11:22:45 +0530 Tauro, Riana wrote:
> We had some questions regarding events in netlink
>=20
> 1) According to netlink spec, "Events are considered less idiomatic for=20
> netlink and notifications should be preferred."
> Since we currently don't have a response that matches a get operation to=
=20
> use notify. Would using an event be acceptable?

I have only glanced at previous messages but would it not work to
include the counter values into the "event" as if it was it was a
counter get?

If it makes no sense - it's fine. We have been adding events in some
places, too, in networking. The thinking is basically that when the app
that does the user space monitoring starts it will often want to know
the state of the world. So we end up with "get state of the world"
and "notify about state of the world" which should really be the same
format.

> 2) Is there a way to check if there are subscribers to a group before=20
> creating the event message?
>  =C2=A0 =C2=A0Currently the subscriber check happens in=20
> netlink_broadcast_filtered, but a reviewer suggested we could
>  =C2=A0 =C2=A0optimize by skipping message creation if there are no subsc=
ribers.

Yes, genl_has_listeners()

