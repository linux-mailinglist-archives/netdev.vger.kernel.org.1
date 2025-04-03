Return-Path: <netdev+bounces-178996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7714FA79E24
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 10:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C37CF7A635D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 08:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274FA2417F8;
	Thu,  3 Apr 2025 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ik/7ZNXR"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927492417E6;
	Thu,  3 Apr 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668906; cv=none; b=mGZ23Yw9R6VmJ7MuRIAXeB5vrqH7BGsrmMgg2W/zlEK+aqP6lMQtk4KJ3Dq9M+7d3S1m3g7dLzk/vEGdIfbusCWwlOYl2ZWn5NSctALWX6Zd4Fpwyd9zb+9ytv8VIQnKf1Wj0R5JPlkGakPnYDi2cY26rL6tHhwPRXMNufpv5EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668906; c=relaxed/simple;
	bh=0N/rEQuyTC6PaZ4nhkwBNvr/kXRCa6azJUbuvQONoCI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qSB9UffVQcbs5XSJro3QDXb1KeMpxlD1I3D0mOoXqE6NrGCubLk6hZr8xMFV1qz8RNTFJFZNs7BcFa1em2+SSr9J3DO00sHarD77ddyAhW3LwJJr7BnU1HKB05F8V0StBPW7jHuUI9ioDcPhWavYyBYxcQZw/CIYpfEyW2kFFqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ik/7ZNXR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0N/rEQuyTC6PaZ4nhkwBNvr/kXRCa6azJUbuvQONoCI=;
	t=1743668904; x=1744878504; b=ik/7ZNXRflWQrvT0snJYaYb/uBeK1vMt7O3ka4WUEs6WDfN
	w5wHqkEH8Yq/JAFGSy/oLAqOxLMWu3rQ/cbJEuwlHzna9hWrHSTn1mMycuUuEBNIUy5PlojS8pegn
	G1IQrbUsnyvfki2anbo5uxZO5s66QW9nWQsKYE4F088OuNLQnct5t555rBDTGdfuHOCrgajxar4r4
	44V8ujeRTDCvsP/JRdhPDVL+B/HR5nTeonJzQGaGrf0EYOwF92GyX1Zi1qu7w9PwW9eUx08o2UMeQ
	dPP8nWw6Sdjhp6Hj6nMFvb1+UgohZM3PilHff0h2ceqqjgPXtauUlBJVIlbQSEmg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u0Fvl-0000000Ejz9-2DwC;
	Thu, 03 Apr 2025 10:28:10 +0200
Message-ID: <694ac5d71aca5ea08674fbfa0b803589c3cea315.camel@sipsolutions.net>
Subject: Re: [PATCH] IPC MUX: Add error handling for
 ipc_mux_dl_acb_send_cmds().
From: Johannes Berg <johannes@sipsolutions.net>
To: Wentao Liang <vulab@iscas.ac.cn>, m.chetan.kumar@intel.com, 
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Apr 2025 10:28:08 +0200
In-Reply-To: <20250403082449.2183-1-vulab@iscas.ac.cn>
References: <20250403082449.2183-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-04-03 at 16:24 +0800, Wentao Liang wrote:
> The ipc_mux_dl_acbcmd_decode() calls the ipc_mux_dl_acb_send_cmds(),
> but does not report the error if ipc_mux_dl_acb_send_cmds() fails.
> This makes it difficult to detect command sending failures. A proper
> implementation can be found in ipc_mux_dl_cmd_decode().
>=20
> Add error reporting to the call, logging an error message using dev_err()
> if the command sending fails.
>=20
> Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support"=
)

That should've given you a hint for your own patch's subject :)

johannes

