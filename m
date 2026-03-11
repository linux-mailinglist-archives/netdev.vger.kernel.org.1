Return-Path: <netdev+bounces-266741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBiZCHu2sWl0EwAAu9opvQ
	(envelope-from <netdev+bounces-266741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:37:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7823C268B3F
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 330763011842
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBE229405;
	Wed, 11 Mar 2026 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fObSmMwU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05B20E023
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773254090; cv=pass; b=jxlYmTKXeT0Wkz5aR9g2Gfw4UeCYgZ6CMM8H4rnxzjy6eSkF67uyy5GWXLzYjAd/2XoDkEM/RvJuNkdhPP8FzOD43R9C5AvaZmPYgWTy9lDliI5ffSE/qPDI52k6qJuJWGXKXQYBhZA9nihRh5ORV8Yodrzug7ypCwtF97oZzbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773254090; c=relaxed/simple;
	bh=he8tUH7QVpVmguEgNqoYDYanfQslOupF4XsWFpqcG5g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jPeCqFt8jmI7L1ucHl4tG/6nVkRWTs5CvKSM+RbAoLh6cLeYsyNtfmZ1eKvOtuH7FtUoaM2ts54AcrVgDMsMUIWmLo4iXkFsxieD/9QsCw6bXiFhkhUVxQe29j5zwNbU5hyEG2n8Q5XTYS7c8CHqtYSVKX0SpQ1ZY7Xkf4XQ/SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fObSmMwU; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ad9fabd08so297250d50.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 11:34:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773254088; cv=none;
        d=google.com; s=arc-20240605;
        b=ZWpDx8Acs9uA9wooBFZES7v5U1ERtjdc4Hc+daD7dc7DaZ62LY8CVBbX8GovRP+k4U
         wHGXSNCnhkvw4CH71yX4frnW231Z/9lbPK8LJhVrta6KmXyAimiv7Ct3gBylWuGkUc7k
         CLAuCNgchHkXThJxVTuBrjHIuhse+KqOExohnvfp3bfqqXVsVs3aMpBcxTR6fj9XxrSF
         bw/urjlina4wAvDY9scXfYlhSAPvW4r8p9uqKxoDZGUMamueO3F0CiF9DE+3p/TQYBaT
         4cf9nCk+fgKehiCIW8lu5cZrQkmrYz/sQebi0It6j98FAFi+aNxRpyUsk7tDdpokzLJE
         Rxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=he8tUH7QVpVmguEgNqoYDYanfQslOupF4XsWFpqcG5g=;
        fh=PB7M7k9nF88f07lgNGcK8dvi+Ly75QXAFrcuw78bJ7Y=;
        b=fwf7H1j9WsalCVMRbwdQuu8rWRyuwBP6e+gIs5RS4qy9vLbBq0Z3oVor6QvS5MiX8A
         ZkvCaLkNJjF+psZyB4xqPD6Y+4NazSko1BYEa8NKVaLiOamcN94zkrfUKZOqD2RV0bIh
         tKoEC+nVHwwBQw51Mquqb9bmzkL2zvSLSmlnfv21eKKMNDoujvWynyvcz8H4xJICsC/A
         JT9I60RFHFlQmhOuKCJBvJJ65E3sEY92eySPiyVfyfuO6xB8PRP6nJrQSmOOzzYDcrcy
         MTen5SSM22ohqU9ifQoMCO6bXJeYbFWR9Z4JjAp5QbN1rjsUg6TPsr8nweVkOo4LPWq0
         ihag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773254088; x=1773858888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=he8tUH7QVpVmguEgNqoYDYanfQslOupF4XsWFpqcG5g=;
        b=fObSmMwUsIjczfdzUuTSYJc84Jlt0dWsKEMhRbPJgy7y1V70t8iHATaIwMdwPuTvYU
         P7MDl4ArxCtcQTu6wC/hLnFlF7+tPT4pwu+vR5Y2Qi2xTnat06lJFfewP51y44xrT76e
         fNl4BPxYdwuK+9EuSZs/ql2YwVFfDlLf1DQwn88FDEVFTKnTpBdsDGLI1wST6tOxoZK8
         blkkUpNE+inJrI6RQMjhKew5VYpIrj5AbFF0J9rWHK/o7/3IxbwGBh/K5ZBzWC90qKe8
         29W1QSk7wm8U38CPeZboKYFOZzjtDg+19RhJLiczM6os8O3w1dZXqK4zf/UO/H6sAUnt
         rerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773254088; x=1773858888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he8tUH7QVpVmguEgNqoYDYanfQslOupF4XsWFpqcG5g=;
        b=ROZgaN7jc7c8b38PIczgBw8UApH2Wy4ew2t56C4u53D1ARAstbmrP0hE/aCMgKAH4E
         rmJN9ml4CVyD0ae+Z3MyveDbaigLtRDC9glmNu3Pk/XRmzYIvWo1vGbDHfjJMt53k9MU
         Xmg3HcfO3jYRPI0cvx8CpA+MH69s7peZNsIAlNAiL7Shf/xQO+HhnOvquOS9Cv3Jn01r
         PrFZmrUBara11iwiFwDea30y3IPib2Nb65PKfZUdETvlZiLvsVFYwWZMx4+UqGLqN46Z
         v5d87GAdHBSKrPy5O/ROS68Eg2hYRUunIHos9mbfCNFDP37nHGO43G+zCfSNWuybwONv
         N68Q==
X-Gm-Message-State: AOJu0YwkLWuGklQWPpJdV21fo3epkGVaq6DHf2Actm+OYx9X+3EPF0m6
	VzmQH7Q3KvTnthwmBZCgUH4dW4nRoXFXI1s8yObYH0bew3UibxbHCFDTe583gTsVyLpMHcUYuDL
	TrYQ2xsCaSMO1Jw56FoXIu/Yn+VlrgiE/sEBi
X-Gm-Gg: ATEYQzxE13qZPAiMWxgvl2oy0wXtbFafpT7v2HoGYgM17bm/pKnYVjC49LpTFINhKZk
	OPIEzzW9f+onNLH18YOb45mQJeFX8PhIqr/KSsCSdhvOzlroVRvup0JbZ8NNzxLQcFz9HeJSirI
	VLZhYfgVOyn6G6W09y7X71U/ei9MCI/LtfejWizbmHq97D70LIJuhvcLK0C8HlK5Ynb8KKjDFrC
	PQp8I4ldGHkMUeuW+b8BjY2xIAKQme/7mVVbw8MAErhsjjep1hASnn49xlUJ2mhdGhgQL2Dd/xM
	N4P86HSu
X-Received: by 2002:a53:d68b:0:b0:64c:aab1:89fb with SMTP id
 956f58d0204a3-64d656d6017mr2432596d50.32.1773254088248; Wed, 11 Mar 2026
 11:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Wed, 11 Mar 2026 20:34:36 +0200
X-Gm-Features: AaiRm52f0GclXu_AijBjtzUoQVU2XZw55qpcMdBquY-Fx_MYlXAMTC-RLhAKYtI
Message-ID: <CAP6Zq1i31Z0kfDST1Xcoftxja-TFaxgSjKH6jX5eY0AGdASpTw@mail.gmail.com>
Subject: stmmac: TX stalls with head OWN=1; requiring manual DMA kick (6.12.63)
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266741-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tmaimon77@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7823C268B3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Giuseppe,

On kernel 6.12.63 (GMAC, normal 16=E2=80=91byte TX descriptors), we observe
brief TX stalls when sending small packets.

During these pauses, when stmmac_tx_clean() runs, the head descriptor
(dirty_tx) consistently still has OWN=3D1 across multiple NAPI polls.
Descriptor programming in xmit() looks correct (OWN=3D1, FD/LD=3D1, CIC=3D2=
,
length =E2=89=88 60=E2=80=93110 bytes), but reclamation does not proceed un=
til a later
event (typically the next TX).

Reading DMA_STATUS during the stall shows the Transmit Process State
(TS) remains active (TS =3D 6), so the TX DMA engine appears to be
running, but it is not fetching the head descriptor, and the OWN bit
remains set until something nudges the engine.

As a work=E2=80=91around, we added the following logic inside stmmac_tx_cle=
an():

If the head descriptor still has OWN=3D1, issue a Transmit Poll Demand
via stmmac_enable_dma_transmission().
This immediately resumes the DMA and clears the stall.

We would appreciate your feedback on the following questions:

Are you familiar with this behavior in the stmmac TX path (head OWN=3D1
in tx_clean despite TS being active)?
What conditions could cause the TX DMA not to fetch new descriptors
even when TS=3D6?
Is this work=E2=80=91around acceptable, or would you recommend a different
trigger/condition for issuing Transmit Poll Demand?

Thank you,

Tomer

