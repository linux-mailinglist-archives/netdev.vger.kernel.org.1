Return-Path: <netdev+bounces-128994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBE997CCF0
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 19:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E5F1C22023
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76019F469;
	Thu, 19 Sep 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XtvPqpAu"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA7319D083;
	Thu, 19 Sep 2024 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766158; cv=none; b=On5CgW2qJ8kC2yVEqBpwrBaacOV5yplZXosTm10j78er1jmscttcMY43MXUdYrtkBU5vs0nfmq1jWO/HhGOew8lo3xaA8pZET4AW7obF9UGP2vuDMGlbYE2D3ZFWs+4UbNvP84A9nj3dgfh1rn9Eman0ib2HDhnPiYcqP7j671Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766158; c=relaxed/simple;
	bh=hF9gkHSrgxODmGVWe8tfUQ8BeJFehhjmUpoKEAcnOb4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ZKB9e5t41opjjbDVwxziCWXoAQ31CR/HZBgZC6jnVDtvFn2bPlUESSCd361ghYGrWuj6bifdnd09t/QEMDXYk5oAQ3d6hbDICTJGB5blz3ZYr/xGq7Vp1GxzfkPCfHaMNctRIT1d9FEWfyFQDBSdmc19DMGGan5XW5rvJQmp/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XtvPqpAu; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726766133; x=1727370933; i=markus.elfring@web.de;
	bh=SHG7ITXdkdUtwHX00Je/W7DpVa2A2aCxRVlxKDTmrM4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XtvPqpAuXLXMGq9NkOjI+s4WSuXqrPiIUZ0CtXWQDe0lXqwY3HUs4zQKm+dQZjOA
	 CeY2KuOGKqkpselkCfp3roY128a4xirckhNP1tvoaBNU7AjstXutB2K+O7RttfUqU
	 LRUYR7g78B7x2Qv5n4ZaK/MEj3KI6LAYNZMgtTOKRc7lZ4Hz9WSZ6iSa//qTF1Y5g
	 BucHyskN1EBkvotHwPygPyaUOivsfQxlTgC9tVUZObvjVlR5qEGxny+YbdW1vKtLq
	 nMyQaE4Ay7PytUQWkuNOojkP6Kk4SwSbuoB9XYMpIQ0I1ix7AapZ2vhlEqP5sLoM9
	 5kHSNF6qtbFVY/WAKg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPaIK-1sebJu3RX0-00NJov; Thu, 19
 Sep 2024 19:15:32 +0200
Message-ID: <f3a2dbaf-a280-40c8-bacf-b4f0c9b0b7fe@web.de>
Date: Thu, 19 Sep 2024 19:15:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ice: Use common error handling code in two functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gMNfraoF6fnRh6XZ9B0roLh11scolJMqzwhmHZOQ214ud0NACJd
 IkpkpEgDENC0uUCHlak9b7WaLqEeShJfiCNDFruc6HQ7Ahk5oPcYvQS4Nt3JUXPIU0claBH
 mc1BCkAdDkqT39s18InKj5jFr6YScqnMcYYwxGtTTCeaoxae/BzURPHSsu9LOsYXc1fbju9
 8cruhrqp9ll38U2VKIE7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kTn2p+qB1f4=;PtSZqJbk1axhMX5YnG8jpvXVWB/
 0wX3ULRchyO7xJ8emL0RzwVuFKdGSRlEV9HpOwmKZRKQ9hO0l6oCL8jRGJ/jg4myBWLBuMUET
 XXZQE6Ye3CZEjGJDBpK9Gw7CawJfWjsaAlg4ocbZqzkivXF7omyLkyeGsNcQ6bvlzjXwuxmqp
 LCdcQ8/BjxiaQNozlvu52OFyTFfl++rDmFh9qO/Yi53ciGE8K+wyliXfaYwAGIIOkJp6W+k5g
 AeoVC8zCni7Fla6R3JqMSkmvamX7SypGa/6mMg/gFbDuM+/E1ulqqRk5F7Mbfl5OeiC4w9Ngm
 FLSuRDMRIS6g2wXUeRHR2KsT6/gELsFAUF2ep3tymfbsIUpyhtHnZvIHDTqm7ddSo/m9TpdNo
 k5BQ83GUXpEzhzocCHHj/Dr02hVGMRdGg0BWpdIn7zOcZlqwoy50XSpsDtG3BMr27ED4UdJjl
 JyQt+WhIW9c1ePmZy0P2e+26e6bBv7m9Yn9beRk/jVrGVdz7RJOQui56nLQDMEeSWAc0WUUSg
 f2lgxKCQfSt/Oo1NN/o3htN6LLX5xAQCQrKoejpMHqs0a0TXIBGZpUSr290Q1udGmImnowX5L
 ndLXVTCojx3n+bfXLNMBWEv8vb5MJf6ywFUgplMC5bg4reJrjBe6c4shm+vqSQlGnI+cVPkLO
 qxQnWyaAqhbJjzoxBWnD/RB0zzOPhVzXVDa0mlZGStJfmFLJSuzojslfKI3ccG9na61akPY46
 fUlW2pkU7t5c/uDpJlLZ7gqGbT3VpUsxROGY1tWFugx83QI0Y7D71OcSH+/xwouA1Nij87Xa2
 Tp401BxjbB2RCMBnR+ZAx/MA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 19 Sep 2024 19:00:25 +0200

Add jump targets so that a bit of exception handling can be better reused
at the end of two function implementations.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/intel/ice/ice_ptp.c | 32 ++++++++++++------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethern=
et/intel/ice/ice_ptp.c
index ef2e858f49bb..c445ae80094b 100644
=2D-- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2813,10 +2813,8 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)

 	/* Write the increment time value to PHY and LAN */
 	err =3D ice_ptp_write_incval(hw, ice_base_incval(pf));
-	if (err) {
-		ice_ptp_unlock(hw);
-		return err;
-	}
+	if (err)
+		goto err_unlock;

 	/* Write the initial Time value to PHY and LAN using the cached PHC
 	 * time before the reset and time difference between stopping and
@@ -2829,10 +2827,8 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 		ts =3D ktime_to_timespec64(ktime_get_real());
 	}
 	err =3D ice_ptp_write_init(pf, &ts);
-	if (err) {
-		ice_ptp_unlock(hw);
-		return err;
-	}
+	if (err)
+		goto err_unlock;

 	/* Release the global hardware lock */
 	ice_ptp_unlock(hw);
@@ -2856,6 +2852,10 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 	ice_ptp_enable_all_extts(pf);

 	return 0;
+
+err_unlock:
+	ice_ptp_unlock(hw);
+	return err;
 }

 /**
@@ -3129,18 +3129,14 @@ static int ice_ptp_init_owner(struct ice_pf *pf)

 	/* Write the increment time value to PHY and LAN */
 	err =3D ice_ptp_write_incval(hw, ice_base_incval(pf));
-	if (err) {
-		ice_ptp_unlock(hw);
-		goto err_exit;
-	}
+	if (err)
+		goto err_unlock;

 	ts =3D ktime_to_timespec64(ktime_get_real());
 	/* Write the initial Time value to PHY and LAN */
 	err =3D ice_ptp_write_init(pf, &ts);
-	if (err) {
-		ice_ptp_unlock(hw);
-		goto err_exit;
-	}
+	if (err)
+		goto err_unlock;

 	/* Release the global hardware lock */
 	ice_ptp_unlock(hw);
@@ -3168,6 +3164,10 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 	pf->ptp.clock =3D NULL;
 err_exit:
 	return err;
+
+err_unlock:
+	ice_ptp_unlock(hw);
+	return err;
 }

 /**
=2D-
2.46.0


