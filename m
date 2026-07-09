Return-Path: <netdev+bounces-306056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Oi1xGnJDT2p4dAIAu9opvQ
	(envelope-from <netdev+bounces-306056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:45:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C0372D4F0
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:45:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=excfjtwa;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306056-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306056-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 915B1301A510
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3781F3D75AB;
	Thu,  9 Jul 2026 06:42:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBD73D9025;
	Thu,  9 Jul 2026 06:42:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579345; cv=none; b=edO7htLFPOqplRhFg1dF0XezCjyPfq/mCbCXTD8ODZM/q0CpHaL8P9KuEtNUAiffP48LN6BzWZ/bryHRo5F49y/YZlHCQaVlOlQSRdEH16kiv8Gmtcd750Vp5IMDonzsWbpVIZw6v/PFbBOkoJwJG2MP+Xc87W2svRH+Hwt2OD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579345; c=relaxed/simple;
	bh=lDroq1H8lPiC4vJ5FULxdPAbVa9mrqRKJb8PyV0prjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuLWixAlDT4KMGEkJ8yOY0SYR9klEQf5yH6f7RCT3Hs39CkMyg6QHI0km9pCsZjwURDPcAiC/RGHW943Ahd0wEYWlkV91sBtM+SXSp7bqZ1gI1Ft/lguq7nOoi+alnrOq21+8WAEFEeDcb3NJFZcVFTiNTnrcZ8ZObL0CsrkO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=excfjtwa; arc=none smtp.client-ip=212.227.17.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783579335; x=1784184135;
	i=markus.stockhausen@gmx.de;
	bh=ei+d4Xn8DoLb/6CiZ7RSCa5ryRqlIEk6fUgtI4AurFE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=excfjtwadsg7ol+EHmzkcpBMxX9/E+kg0MOZgyB9UjGn8e5PMQU1/cqXkP7xkmrh
	 9vn4oX3/u+driwMo5ayQjpu6GJ+KB8FmOskGambbcw9UQZnzk5UF1opQ3IMt/7eTH
	 4oTHRfowqwX/ejF6/ENlYRMhVpFmLZtz83BYLPifzf+HMx7TsbyLrB8YBTY2moeVP
	 9tBPlcsGp1V2NblIxLhsknDKD+upcGxJocpN5pA3LgMBNWy0OERk8Dh9qvSHdgbR9
	 /i4CSKMPyb0eJzeKBgqhwntb66XSaUH3NsLnbMN/J1ZVutZSQx0nW8pz6hmOz5XJU
	 Bv87ZiF8LOGzqfztcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiacR-1xJXv62X8p-00ZkVN; Thu, 09
 Jul 2026 08:42:15 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v4 8/8] net: mdio: realtek-rtl9300: Add support for RTL839x
Date: Thu,  9 Jul 2026 08:41:57 +0200
Message-ID: <20260709064157.2865063-9-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709064157.2865063-1-markus.stockhausen@gmx.de>
References: <20260709064157.2865063-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SUZgU+pZldcREEHCqRB+JfhP9El8uTKfd2BjD0AQBtD5zTtRFlv
 oKBf/fpsVvh3d///Ap1DxQD3bYZgWehdxfHaFmPyYrNmtontjHbpJCUoaALLSx25PP9JHwz
 ny88YAs0AtYFU2MARySpYsMOWqF+F8wt3HBR538tcrVaPRXfJIzAug1qoGywJm9oWAthQKg
 RtmxyL2M0Waai35yutWgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BVjzlAhTIes=;qxhBx/Ru7jjquJpMgC8D+LNcuYL
 ZhKZEkzHvgD3yaZiclO8kVKo6/pYYXn7gHG2lJAWRJZY4TlQ2Kfuzklari7DoSZUkmAReJWPY
 pXhyRUCYrwY4lpnHkgIJn9E/F9eUR4F5YjthA2kbVM/Thb40U+DueijHEox48yZEerLGa40d8
 3E9Fg3e5feeY/bKNQk0uoknd6R4tkjr5Oi3uvaoVBmUZ3Gw50GMzftWmu1XL6jt7MJ8kZH8U8
 CdjPjrJ1hVGF45ycoXoT5VohlKNv+ADtq5/EgA+c69BRrIfUMPNeT56353phGAytvBYdVs4ba
 hh4Gz3vDqMBalrI5qSqmwpZ47Fd0eS3AKlTacMP/0wyX7yMAHWCM31ExOd4vzpfsM2OF0s+mR
 JkE0opcEP+tIK0ah5BTTUhLFnXYf1mVOWIjICFoTvPD09s+7UmmHNFVWiG3+SETKmF3fGf9hl
 akUVV4u+923qkgnCboE1UjC+8cRJE3bQdyUkiEXEO7NN3QoZJkC9bBbD4DdTU2yXJDc5O90L1
 bUSZZss9RtYOVqw4VIh25wSz7hMi51Poo47fS1HnuaYzeAtI7X17dB5tMD3p7TkbuZ9Uu+zhQ
 o3TERRep5db2Wh8jlGJ5E1suCO10Rw30IRZmWUIMXIvLiednC2lkCczVEcXo48h7GV1BZMEMC
 kr//p9HIgwQXz/oBvpVrmhW2s0z4SezUWReREFgQCkK1dXeYsN37CLBbHDiQxk6lGqQk3FQ1q
 6XPG4G59fW9hzGqX09wbJx5MQycUgQL8aGmJJxR9knKVvpl/zQjD3H95BZmhbw6cdTtOLMkE3
 vlfo2l08qEbY2KCukgSSwOh/toLUyRhu8AuRRWKM3vDnuq31dz58Zdb064BC2DrQNhhez8jTY
 70sSJ7AgVsc0LbJQZ58vQbZmrIA4Rkb6+k3bZVomJBW5pAbPzDTsP/eeX1WzaeNAOdtpH7+/w
 9b1E//aQ1PtG++lZ/4AVGtv6OwSch0aD24MBl/ccW5P0yuLnzZmFz1eP8pT9TAnS3ixiDVqIX
 ZCu+D+Y2hSmY98J2nqYIgZCEWlxWZsBgN61MqxBrmJiemfqnCyXJWkN0UACT5W9xs4FwrGNd4
 JMiNZ33hpCiPabjYSRfDV0XRF8eMXd9dc2iNVVunanuaBrEpQp3mvgv1g2hI2q7wTJEKeSP82
 5W56BzZ/U0tMew/OpG6dU/rwbrT7V42tlfelq/fJK+mL1Uh7KEHd8BnRDXa8TVgGd74b0lIL/
 IO24YktWzu/lnAVD67+d0qzKnx4d5zjpz5dVb/32uDhhDOgx9i/4BQqjw67YBWKvUWyNVlg9F
 DrClXALed32sW8r4Nhc1EjI4e5LGh2GvLy5cWwyE+DXgpKLze6I4CQw3kcO3uy9JaqJBhpUl3
 OIGR1vUmp0ZnCZFhYj9aKcEKGkgzDu+lRA07H5qHkHnLlo7yQusi2poaRviGxI/a4gPM7rEvD
 Py+cXYdATdM6o+RHxMDGt0LYlYKUakwA8JFJVTUthGBWowWMJyTOKVZK8eC13UWDQ4aySIUe2
 RIntLyEttthYA99fl8ULSi9vHKBLDQPqKozO9hS//KWJtkBJgrv2/FAGjbXjyZryVDSB7EKg/
 GiRwf1AhyE+ZaRbCvZmy34tCGvzpdVhCXsEoO+qcHor8DJD5IONiyvFhjNbixe9/2EKJOnGp+
 lZialjAbYo4/REfF4Jlp4w8o9lQ4MzOLAtl0mRvyJ/Sz/b9nD818bd1X5MKizKMBNlrd3WNKd
 i7k/cfSLi+SoqdsuOL8obWMk8rRz7x7FtKst7/X8CqLjEfcn84S0EjgM4G982gSzNwBx3z2V2
 gs+qMeIQlelv8wJo2B3FvGxAsVQWTU4fujDItPJmb6xaEjWbC33Qs0UiCB33dRx8u8t/XCuWZ
 MZu6De+TApSPfGGUrcXbAxf/iQPmvQRHP723BZYwAUOC5HSPLu4BH0Kfiu/NY7t1sRROngmaQ
 Nwr0MMAyuoMr++aiJ1a9SCk+I0GZEfVcRQI9VvjZkS1J9T+ITaenCpwRxtAtOYoYafx2KJhIM
 qxftoNf/QVMscKBr2Dk6W3AG0OrKj7M0X2JNMQrG55qxlED7uIV7AXBgpV7PoNZTLRcV4kyYM
 oxQuTKhBuwsAsvgOdExhVCfnpurWeRUYQbvQfyV/LXripE9dxh0G71viaTEVYp1Bf8UWG1nc0
 wsEn0VOCDA5N4X/d79Dql33/n+VAw2yzo+Ipx7EkpJaJWXXOnN7lgM90KTmpgOMQOjDhbM7hq
 QTn6qYyhuyDq8zu4V408Tpx+5cvVrNyaLeqRUrV8GbuRZVuqiaUzJFCjBoKDuG9Wp9oRBcXNE
 3ezvfNhHzIYo+EvnX0ZITpIFEvDpFCiOphcxnetabHpKkaJRMYXib96BaDYYQvCDX638Ek2K1
 huhXSe+FANrJ/H6/rSDgq68Hnhgv4td1spPIVaWUZCTi40rzqahBSj6jdzHe4nswsIx+w1Gkl
 mtJF+ClEHkrUT1mRVE7QEhpAnQvfom8e7lQ9yIOO4lYKSdj8KethybFqpZBInMXOoDThbzJ7l
 sRQRVXtJMY1kRSMmr790tlJovkoKfmNlbNnX1kFfvH4hAYomTnFnwBeHg+QdWOmRUGvFkd8UZ
 KJnPvUdasFbL2Rv8lJ6XZC3zxiaLhgJ/XSm2gpcKkm3hvyU5CzzEDZd7mFS7L3mrsk/Jw0u4G
 YVv0W1oUqzvSr0l+6W6alD7Se5WFeRXFegtfTIELX9F9fF/0EeHSmrnMMHya5tMrCdPaUIC89
 bTosPXSFLVvmi5YRlL0oga9WjuChpgJPSIVI4UbuHFC7R1ocV499LDzVTCr9eVMs4A9BzAdpR
 ZW0EZ0hVwBtjAb1l6VCuzseO7/xRJ1i8XtJejJnYtLGygMtJNlfByIWvDb87ilk+5yJB241AW
 dHHeUOkrCMyEpGSpiVE6uxf/Cy3VaZglYY3J9fidzuD9Bqu49N0SLxrtVVCQgvWLDiyzVl/aA
 Y4rfFGkPVOR/tvezo+pT/DmhARAx4A8a/tFc+u8T+LdFYUXJgbMKbugiNUGYKJykoXSjRKYjH
 nNEqn8Xv/jywqF6o3MH/s47T8rEurHDe6aacB865kCtbLu0qRLaZ7Mp+pJQSWNqnCzxu//Hsf
 qBFGMzdRl/iFrJSy2IPN7+EiX1v/PP/+Ew6J1mtQm7Z2pcrk4fSM1bN0jDuRyPeAmCcE29azT
 x5OUInrLJFUv5xsczMrpbaSMoSKnMVHvTb3TiPqKJuZ6js92lyrvV+6bpN5bGgBWfFsAWxLzO
 +k0QUvh9+X5izr26Ms6YnvvO/CiWG+2EE02vk5/5HeOoR7U55pLtg3C4EFID0Y5L6R/kGvm7w
 JS1AyiG4jZLMVFEkCizoh2hgLs1gBhraCEIygAUN75NxJtUlnYLOicY3mHVHfB6302TdPnnZq
 w9XZ5ZG8pHArv/g3aMpWLBzaLJZKWhjP4V8hpjOf/5vJFrwHnSPfphGyX0RaLeYCgiPNiF/Lk
 lq5oc/1AH0IWsjU+Ys51yhAMTsSIXBLx0Bq47m6q/Jh0QklCEnggabXJZrxQkL0MYmj+wXMd4
 nUUOvw0dHGIRcaDdmTN18Kt0pAsDMwApoubLUiddjwJQhZ/1lSdrF8NStA2lLxcyubv4VYLn7
 Z9nkHn1i9+g/SfJZLlmbDCmb4VSJZar8S0THbg6sm7NCDDg25BI+FGtWQRhwL426bCQb/eXOm
 4zye34EtjAwxZ4HLbMkPldlr29HJyHMFCMk6rYxkRs0Q6I56g6ghuS0yySUYWzjAo1rRGIokY
 34lAvqbgHmv/1loFrOeqZgoYiHkmixFl8Y27SyylgCZyTwhqViFQjKKMU4kAnAqGr9vjOvqBO
 JcAixYyehmQ1TUd92ZdykP+NDg24K+lxz9ykn+RRaVKSg0MapTkacfNPNLtbGj2X05lRPNXIN
 FnyBIo63c3WsmPAZay+b/2dS/3BX0eW/KFNlS2PE20CE5DhFVm4xT45KNyttdSjBlomhTI7cc
 pbhVi7G1EGLaUkzjq3SG7gTvpTIylHHmTDo3uUdcnZrxHCxK+/UwZlSUQ2vf/J2/Ms/4PYQcx
 1S7jaE2MH798IZL4ObFW0zYMrWynlGE0K7VnVV8aI8rk1An0B8Kgcwnrm4SiUJp8V8tnQvEBb
 YCBSebx9iQy2WlQu90hZ7wRIfdI98IPS8TWhTweEmwAWejaygp34O4ieYuK+AlIS4wdereV/k
 YOx6L3SpSp1HjrpfskKj52bNuqpIvJz7pngPAuSmTnxWA8CQnp38qf7Y+h8h/gSa9HnvS6FkZ
 qB0IkJgT1MTb50jhoRFVPB95IIKIVlULOjjnVXN9sJLa3C/KGnh5Aag+HnxYlz/RvlQfEdkbR
 jtF7tk/wtlv95ljujtA84NOLseJwYp5O7h9psIgTKZUf3TzEr6egvL2+WZnR2XLNLZfd6kDqQ
 8zrR0AwPvYK0nPmP16l+pYmM+RiI0r5jv64t+8hUITlFmFds/BbVCal7+ue4YyP3sbnSosD3G
 CrQf0Oe/GLtWTrYJa9opjJARtHbGYKZVGGawMQEFiCiblqxv1jnwJuDB8Grng7brv3H8s/hrV
 Ts5VRMbEfKhrOyyQfrGvnkM0RA/HRfdZ2tJ+WQs8y4CvoWTOI+djvM6OyoZ09EgJorWl3Salh
 ulyzHkfqzRZKN8T1/YI/S7bHmOq8jJIpZZTaEOd5glv45KRWP4da82LzJX64SzX/H6SwJO58F
 S2//MKPdghG/DG3SNvMnKkC7fOr4HIZmak3DXY2OM/a10hGLu+4om3R+Mj2nkZPc8TbUj6pMa
 1g/MShixwqXQEdotLgUVagjLX5Ivgfoi3YnbD2FPA3A+7L9RlOL1zD8t7g2xj6EV8S8Uz+77B
 dDnEPNIXIFheUzTR4dHXHE0wk9gShQ8LAjo7nzKwkvxuiYxj4NsPFL/JN7MThVmJ0ypqUyV3q
 jWyYk4NzU/shcOSgTskzL1NiNXHU7d7C/JHzBHDYVsNThaxMd+8EqKAxh8b3tAwkxdUfrIJnT
 KTAHwEkaYeJ5vg5D0vfoGDFJEyu0FiTp15nSV2psLJxxaipeK3lWq/AqobhqgbB9q7oWGqqTj
 T4iuA8BhDf/R5LTVMW5ga2LwFf8wYixOC22AUSalVbLh+4istwcnj1IgccDbsXwA+ZzLAk3h6
 B91+d+LO0YAYa7G14z2v7whzqVUtbqcnBWwdgIOSaoiXPr1gG8OAdiRNKDb266BgymYsGvOzi
 y+LHdF5HTNRQR41odwS41lrZZdAsQZ4NeUleC1h6mREtoks+cc4xETlcM0aFO+PYjuOxj76Pd
 Pnw6+CxAmtLKNcyfKSwLTxZhaCVnA3QfuNacqtrZURYnha4/dFkiF3A1gAw2eOS0Xtpq9xREL
 dQMSk+DRFXusnP6zrjU0kkJ93yEvTkFKpxxLQgu2dLqEb6QmYFgwUcmtKL/0psSH2kb03pvKz
 uJpR9WO9cMTSTba9O+sjjCmvqMjMnZ0L5x+hSeXTVDdgkAjDCPGztVqCGN2tglrrFn2qePE+J
 Z0nuPdlj3g9JvzBA9pubvWUj9GbnrYjZiXEKQSyglbk/3/olEvPxvYNcUGPLXtwMWgPtj0IBL
 IlZYRxdpqXOaZqESW6t1RBXuR82TOzjwu+4khU+ff77lXPJFoYDsW1BVkgqU/HUhdXfySexEe
 RnSwolFgyDVLsNpqHE=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:markus.stockhausen@gmx.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306056-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9C0372D4F0

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL839x (aka cypress) series. This is straightforwar=
d
but some things are worth mentioning.

- The device has a lot in common with the RTL931x series. 8192 (Realtek)
  pages and 7 MMIO registers
- There are two SMI buses for 1G PHYs. Neither the bus nor address map
  registers exist.
- The hardware has not much to configure. So the setup_controller()
  function is not needed.
- c22 read/write functions must be called with PARK_PAGE =3D 0. Keep code
  clean and avoid setting it to zero, matching the behavior of the RTL9310
  logic.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 102 ++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index a6dfd8d26722..8ee92dbed52f 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -141,6 +141,28 @@
 #define RTL8380_SMI_POLL_CTRL			0xa17c
 #define RTL8380_SMI_PORT0_5_ADDR_CTRL		0xa1c8
=20
+#define RTL8390_NUM_BUSES			2
+#define RTL8390_NUM_PAGES			8192
+#define RTL8390_NUM_PORTS			52
+#define RTL8390_BCAST_PHYID_CTRL		0x03ec
+#define RTL8390_PHYREG_ACCESS_CTRL		0x03dc
+#define   RTL8390_PHY_CTRL_REG_ADDR		GENMASK(9, 5)
+#define   RTL8390_PHY_CTRL_MAIN_PAGE		GENMASK(22, 10)
+#define   RTL8390_PHY_CTRL_FAIL			BIT(1)
+#define   RTL8390_PHY_CTRL_WRITE		BIT(3)
+#define   RTL8390_PHY_CTRL_READ			0
+#define   RTL8390_PHY_CTRL_TYPE_C45		BIT(2)
+#define   RTL8390_PHY_CTRL_TYPE_C22		0
+#define RTL8390_PHYREG_CTRL			0x03e0
+#define   RTL8390_PHY_CTRL_EXT_PAGE		GENMASK(8, 0)
+#define RTL8390_PHYREG_DATA_CTRL		0x03f0
+#define   RTL8390_PHY_CTRL_INDATA		GENMASK(31, 16)
+#define   RTL8390_PHY_CTRL_DATA			GENMASK(15, 0)
+#define RTL8390_PHYREG_MMD_CTRL			0x03f4
+#define RTL8390_PHYREG_PORT_CTRL_LOW		0x03e4
+#define RTL8390_PHYREG_PORT_CTRL_HIGH		0x03e8
+#define RTL8390_SMI_PORT_POLLING_CTRL		0x03fc
+
 #define RTL9300_NUM_BUSES			4
 #define RTL9300_NUM_PAGES			4096
 #define RTL9300_NUM_PORTS			28
@@ -423,6 +445,62 @@ static int otto_emdio_8380_write_c45(struct mii_bus *=
bus, int port,
 	return otto_emdio_write_cmd(bus, RTL8380_PHY_CTRL_TYPE_C45, &cmd_data);
 }
=20
+static int otto_emdio_8390_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8390_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.ext_page	=3D FIELD_PREP(RTL8390_PHY_CTRL_EXT_PAGE, 0x1ff),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8390_PHY_CTRL_TYPE_C22, &cmd_data,
+				   RTL8390_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8390_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8390_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.ext_page	=3D FIELD_PREP(RTL8390_PHY_CTRL_EXT_PAGE, 0x1ff),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, value),
+		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
+		.port_mask_low	=3D (u32)(BIT_ULL(port)),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8390_PHY_CTRL_TYPE_C22, &cmd_data);
+}
+
+static int otto_emdio_8390_read_c45(struct mii_bus *bus, int port,
+				    int dev_addr, int regnum, u32 *value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8390_PHY_CTRL_TYPE_C45, &cmd_data,
+				   RTL8390_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8390_write_c45(struct mii_bus *bus, int port,
+				     int dev_addr, int regnum, u16 value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, value),
+		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
+		.port_mask_low	=3D (u32)(BIT_ULL(port)),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8390_PHY_CTRL_TYPE_C45, &cmd_data);
+}
+
 static int otto_emdio_9300_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
@@ -969,6 +1047,29 @@ static const struct otto_emdio_info otto_emdio_8380_=
info =3D {
 	.write_c45 =3D otto_emdio_8380_write_c45,
 };
=20
+static const struct otto_emdio_info otto_emdio_8390_info =3D {
+	.cmd_fail =3D RTL8390_PHY_CTRL_FAIL,
+	.cmd_read =3D RTL8390_PHY_CTRL_READ,
+	.cmd_write =3D RTL8390_PHY_CTRL_WRITE,
+	.cmd_regs =3D {
+		.broadcast =3D RTL8390_BCAST_PHYID_CTRL,
+		.c22_data =3D RTL8390_PHYREG_ACCESS_CTRL,
+		.c45_data =3D RTL8390_PHYREG_MMD_CTRL,
+		.ext_page =3D RTL8390_PHYREG_CTRL,
+		.io_data =3D RTL8390_PHYREG_DATA_CTRL,
+		.port_mask_low =3D RTL8390_PHYREG_PORT_CTRL_LOW,
+		.port_mask_high =3D RTL8390_PHYREG_PORT_CTRL_HIGH,
+	},
+	.num_buses =3D RTL8390_NUM_BUSES,
+	.num_pages =3D RTL8390_NUM_PAGES,
+	.num_ports =3D RTL8390_NUM_PORTS,
+	.poll_ctrl =3D RTL8390_SMI_PORT_POLLING_CTRL,
+	.read_c22 =3D otto_emdio_8390_read_c22,
+	.read_c45 =3D otto_emdio_8390_read_c45,
+	.write_c22 =3D otto_emdio_8390_write_c22,
+	.write_c45 =3D otto_emdio_8390_write_c45,
+};
+
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.addr_map_base =3D RTL9300_SMI_PORT0_5_ADDR_CTRL,
 	.bus_map_base =3D RTL9300_SMI_PORT0_15_POLLING_SEL,
@@ -1020,6 +1121,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
info =3D {
=20
 static const struct of_device_id otto_emdio_ids[] =3D {
 	{ .compatible =3D "realtek,rtl8380-mdio", .data =3D &otto_emdio_8380_inf=
o },
+	{ .compatible =3D "realtek,rtl8391-mdio", .data =3D &otto_emdio_8390_inf=
o },
 	{ .compatible =3D "realtek,rtl9301-mdio", .data =3D &otto_emdio_9300_inf=
o },
 	{ .compatible =3D "realtek,rtl9311-mdio", .data =3D &otto_emdio_9310_inf=
o },
 	{}
=2D-=20
2.54.0


