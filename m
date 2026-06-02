Return-Path: <netdev+bounces-294024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JdhId5pHmqGjAkAu9opvQ
	(envelope-from <netdev+bounces-294024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:27:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9216288A0
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88674301B039
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 05:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9C32F6562;
	Tue,  2 Jun 2026 05:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="rLDqoHZG"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3372EB87F
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 05:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378031; cv=none; b=ft9w4yFJ71MnYyckX0kAr66CBWjC8ZHb/t6CuMj9Z+WysQus+vT9UF19dFiVM5dO9smpNBSKE8AtLFBZu9VRweGRvqPE7874IFoCY+rg6ZqCuoCnCTcJrtAlJ/YeqYr+gEIbjHB8L++2PumO8Y5NOM+Hi886vKGjkS3GShqa0L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378031; c=relaxed/simple;
	bh=3T+lJofIXF31sv+IGtPEhigsVSa5d8Zrs07gmARwNKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+AcvgFvC7zcrAo0avbQdUJ5IUc+8L7ESrw3s2h4qXe/cjJ+PN8CaB7BRzHt9XubVOdlIUJvKdXz4S5+4yZIgOGCaJC45GCOGCEiznSFOJVB/b92gmpAI08jY11lNue2l+TwkD+O2rVvCMroxnj+rMgA4viPFg4Otnr1GGIu/SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=rLDqoHZG; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780378013; x=1780982813;
	i=markus.stockhausen@gmx.de;
	bh=l00RimY7xLr/NgOSBLaWK/p7ZeL7/Zl8Mg4v1PDFM3Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rLDqoHZGke41TzlZp70tz3e3vOJy92F8KoOTSA8IzsqQ0UI7hVbVGFx7efWgdNwX
	 U2mmqO00TGGmiQSiRdsOO3kgxt6YFwkMGxQ2v8PdckQe9w/0Zt/ctei7PwZKQ6qOq
	 dA0vDFFl0gDYAeRBEnPzHWC1k3cjgMgGHTfozKCCD99mw00guEghxMi8jXTtGeDdd
	 OX8HkTgWuBeqDpLlWuqZpLiFjjkqFdXhOBzO7W7LK8sHtPOZnvXUdmHFquMP8Qsgo
	 W7cRxiB8dMvO4Fo5npZEwp7im2R80lkpwnIuiPbSZvwJQj9wQBwybwl6baXOZw2j2
	 oNUs3AcuBE5iaZqmJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7K3Y-1wMb4b0eMe-001YDN; Tue, 02
 Jun 2026 07:26:53 +0200
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
	mensi@mensi.ch
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next 4/8] net: mdio: realtek-rtl9300: harden otto_emdio_probe_one()
Date: Tue,  2 Jun 2026 07:26:36 +0200
Message-ID: <20260602052640.93083-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602052640.93083-1-markus.stockhausen@gmx.de>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uKWho9ZiSZJ3V91LG+uoBqxCpQHAyRyHXrBnU1N0wSQVFiqvkCT
 Sg/xUgdawMEKNWZz01C9K4AWbSO+er7r9bVJXfozcLlL7HT4ZWcGUskcx3Rpk50J3iOYWTz
 cXqYIw6C70cydgAhAnU4QBgE64Y9zWsEDg3/Dk17AxZ9L9oPzED9+w85wYdzmrRKXwGj2LE
 FhZ5YDkV3v4askkb2YO1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v9Yi/45r7ng=;go3wpePaGEQ72n5Q5PI/pzNpU0D
 upNj91B/7DNjK142T+lc09XdF3oBdhlfOz8JSVABXTpCuzVWm7zexT2HDzU8GHhNRG386aPr3
 0yoFP9J0n+NWfAKIjOIg+eU2zRzPxv552F7GOMS3tCFdX11DWnTk4J8Zr45LlQkvoHxkZfsxJ
 rZaq8Yq9EWDpKabUQDveTXmop1gl/67056vNl6Ma7afZcjjnC/aH9QDId8qxQkJBiyubTnR5z
 jtMsP6DeHh7uH7g4HT+BfBPiutywpOYnSDsovhQzw9MDkN6QT1l1lvOikhxwplfPrb4xwKv8G
 PjzbsLH9qkSd9Q8KHIFmW3CjlNO1YKStQXImjYa73xpjAf0FerdX3qqU9oPadu72yxRHZFWTK
 lgsBrb7Em7qgDWEuEeCW5dZz0maIDcdWOMQGld4+kG5PYUnNv8at4wMw/+J0tiC26zoYEXAm3
 RTbx90RMomMni+umoKCaRhuLXQea3jNdRinELuIOLIaZQugfaXJm6KLLNuJOXYG70A66fR65V
 pV6mSXSkC+BubR9pdTZu0T7JwYc4KSviu2ii2DPBaJmGpme2akpAVqcZk3VXAyVDFmSP7odix
 R8KuwMUl0fM5b7stHdndyIThXpnItT6pNzUYde9uRdZF5VmYLhMVrlFR5/9N3GPMI2KB+wV2f
 s/8TyizvMMZFZkueX0AOKBbeelCDT55n9pz36yu4TMj76ww7eMTSEeP6mmIIAlrswTOljAnjg
 o6J726pYK3znmLSXWxo6j65XVJc7PqRukp4wIzwJsfSoDk+CHm3hrSLlQ7CUk4Szj20bm6dL1
 VxIJEUQaMQBwOV1srd52vsU+X0yFWPEoEiDRBJzu79e+dG+b+pPhnyFQuv376HVjkLwBsjZYb
 gUtqctxx27TWBnDFVHykzIZv+xVwjHNEsrkjsBD0r96b57QOfljdwfbOOQiFDBB6pW/5U29Yd
 ymK7Ew46Aoy4aGlP3u0JactJVCvSnHp38CF7O2TRWIezIbd82vrxGZXnjWICrxIaSnKAc8mzc
 2U/8e4r0EitXbt2hDhQiYISNN6g/jq5jmcbWzfkJhLJNCq43/5W/aAsxv0NI+SyJSfOGg7giJ
 ftZPtWbK9WxRM1rj63r98SLey7prQt4PEsO/AN+gjoQDtx3EQBnaNsnjR3/3NLwD2/ROg9j6A
 fM5pCvk7dkFyTl2O4QcIpGSpdsLuDm+6QkklxJmEKQt7vUDzIX10uOAwI04Zm+7TKQqxa0dp0
 Mh+Shi2WsXaeeP0mNhcftZHQeoiQZHL2akADQCmi2EmToBCTKQSiFVU3adWYlVXcR+xu6XQf1
 FKVWx4mTYJezlclkH0gA/Mpl297hyF5jOmk/ZLpAXfqbP2W6IU2H6sH+nFJAZRnZYedgavzhX
 g6Uq7Kzvlcrbtwij6wZOo05R9t6OmhqE/oy7oBfQD9dLqVdyQ3tMePsh77cKrcIrH2VYCGYJ9
 YMMT4f06/nX5qZFCOBtmTx1As5lDibLfDMOxLCsMGTJrtfBnaWqIVtUJyrfIgzC+sdlWuReKj
 /e2F9Te4tLW9OYP5+8BJMKYVXyv3CSdDfyjkHd9ltc6AhtHfW+afKHxilCCIyQAhMaHjDYM4J
 fFooD/laCJNyc6kVfXrynaK+NEwkOT954WPq6EB3VqyFV+vzm8oLQ073wyHnCQc90qaCt/ALL
 axYEISL7U9uD9EHubC4hjDi3/YeX9t9RuQ496DnL5szx/bplfOCNz/Fe8kHG4bS7D5zZ4q0Br
 57bNPnWf9VQP4xx7Z/4PtojdeB+AtP2nri/Y8et6UwHkLrVOU7vnZhuJineOJf/RyH9QUoeIV
 lE/2Cy6os0FNS+1A4zjpX64Def8S7AmsLG08SU2NNjRX/kmfj5u8nQ23NI3MLzkZLngnLR8mf
 HqfnvOItFIhvhpvByThTMacJLv9gApnIi/3QijiIsTp0hcBmPm4uVb76U6US+shXa/HzsB4i5
 6SgSsh3fJe+06mGznYCUqr2MvbHtVCzrhNLUNrpigwOLjOFG/Z3AMEYBK/vyNT2EsBu74y5et
 D8RhRAFephJwcYIVo5U5rFCPPq+6opyY6mZkZS58XSdLRWncL/WMuNsJ8+qKTbPWFL9LEiUmN
 4VVED/eCov2UdDruuXXtAydZn/GF1kp3COGd1jxMzIGE1Dmpc6O6XiYiIhXylhdcvFh4a/NXx
 0jum6AhgpB8Ioi8/WENhF/WTxJmBAznr8I2ZK+mw3AZYmjPVOhvlg3ijnCaisacN+UVrNMg7V
 vtQAUB/fUMzWQrn65hCKVAqki4J2MbVNa43FgIQqSXyHh1OtWt2KoUXu/p2cWXqJ/MvFT685C
 jSaUUn3kq/XOz/hpgYE4wAL9Ri9Vi1rXPtDYjHPCHWcG4RLkl89+5DZLd5ivSP7rgLMJWAoTn
 Bj9qcL47cCHJLokPx8y0jrfl4Y1Ib/qDxDT/7PA2YREm10xx0O06f9swEpwS8FpWcnZW0eTZI
 yHy/KLG4YcRuWJdgzfPXFTi2YDpoCWPcX9YCNyojZ01I6DpTOEk3Le6fpRjdmNIc06kvdp6AI
 IRRivoJ18FwPVDRSJ8z477Ip88HP/sAX3czXquuWhM+VE9NMyATooIOYIOvivh8JLb1iiptes
 6Tn3vAZAuZIrXr3Pt3gpY8aV5wDABSX0GMACGobaA3dFZJvju3vAptLjZSgir71antL1kbJdH
 GnXjljcTASKMp4yG5NMQcFIQxSwaqkC8LaNmsCjUIX+WhaRPksUan1V39HWSQQNAAK2VO5+Ey
 r7H5mclduihgzvhkt7VLNJrt/8ZeZshRC3Q0alU7uAhCZ/Mk6sLR1wBFGRrVyirfKYItlEqrj
 LKxAh0KmyODxEd0sgGClX7NaoDdTjYp4+Nd7XBGTYRNKL988bcKDcdNDbxvu6zEHqoNO3OmAw
 lmlV8xDGP6lcjHKYpcEjiGhB6ph6Nz/5aAxSyoT3kGMmnx3v7D7RDmoUUbiSxjVUSD2y7sGSh
 bvWU/V10/jzMLlVDnvrkRXAMri5ALA/jOVWQdDZELMi9uPUzsF5pRpfgo4NbGhjarS+A4t5G+
 C5MKaFIhdXtaT31RsBvPF/C0+6BYhpL5wAzcFGPh+lbouqjs8+boRmzSM2SKEr2nG3EBpoyha
 xsiRUdk/qs1NfT0NCrb6aEV6XeJE+MQ4enqtYQKJGe2Ks3EEbJYSaRr6sTiENpbs2jbHBIOkN
 pPKTTwtUW4c8nRUgXKIl4EwzaSXQkCqdyB0DhlZxM/NpyxFkXXp0jAdqlTkSXdSgq68jDbu1s
 97kzG5NCzL+2nNZOxgP63b/LuONrCFno7HurIwl6NDTkte0ojo6XsSh3em/GRk3DcrVusawrh
 Mg5ef06xnQOih6g8R7jljTrqHiOnJ0GDgBMUzFXaWCCVt8o7RFHcD5Jx2waFFMSBzunQQL4D6
 8VoUzw8pbeCoeYjaUj5CPhIhTZv9ceTij4eOmc2h7uuBWoHGwTmHzs2FIVlsN35DvajLb0NDH
 OCtApPOOPmL4O8UGeKI7w5mrUKT6J4ep/lu8lQ6yzXs8PjqI5FdUXRa4V00p1wQY7geGdnQ6f
 cwJF/7Lx7ZzQsrk7wg6Sg8PSE4laRQ9PErxnfUJcFAX5stBjkA9o+09vY7Tpd25Bcw4JuCMt2
 xuPRBX8T4dlBn/WdTGmEdMX4YxSUkg9WPPOYfrehI3oT2gFI8cOAfVYTLLvg1nru3hgD4zrem
 jomee+uxlPue4WpWt0WwRGZ17k3G2ndlaEfhGRL2LusbZksC2X8h1YCmM+JQ4NsCgIA+SU/la
 pA+IjJ5MRmgCYU4HkHMFRFColbCb8Sd8DGRpYfXtO6juoRGSc4mRqlg3NagR2XAog3qckqevE
 5nXBj068G8d7b65FHbq5znSRqVBHu2SFZlvFUyW7gFbHlFiftUJ9aZjkXt0QHov8o03tbMVPE
 acKFaPsC1FKIqt6jB5CQ87nu1lJuFWnF/hVJUvp+0m5YWAXwS6/4ep2Y6pJ4dpp44LCX9rCYn
 C30Fln62QjDkeOjx7c9rVxJtW5sTpyPMb26s7i9fj0HK9iXCOpdaqQLo3zOKoPUYQId/jDRrM
 blc6rrJfAGfzgCB84QbxOKt65oIu4lONpm27BMRUu40A4rdFpuiOYKhW5WRL9CK5pxbq3xS6+
 w9Pb5Cl+PlHU+h8+op12kebaseG0jLcs0dz1k8Dh44XVY4hP8GuhMvWeJAnrFIm2Ca/Ogq4gs
 +VMRKCVu+YSqOi3rUMGnv8o0q9FvH4ajIIMx7ShR7YV8AzrX6ENNxuoEEgH6Jz5HorjP+GEND
 vCiCETk037n75e/Bc/Irl3YDJ02smWJtncYAdgWXGLxtGe/o0iX1qhGRURscOYX2l7gExo7RY
 SNQgOLDPTNt/0Eb/DWBtMws//wLJXtEMplc4ugrnvFAjLZc0XhCVDSZUlejARpmm8FEdO9ssD
 OvbgwKr6I2s5SeA0kyYY8/2cPy7ybuFq6b5aJTjHv+cRHxNlq7K4L4T0kL8PGwKKw69vwSjPZ
 rc2C29IgT9d/a1R2sBZj0CY5MxZ01KIeVNQ5d28vj4wxYvtlvYg9wRxomNqwNE1BPmFFHI/rv
 ZqLQF/vwrJeJNc0PCPIV6jtul9qkiXZoY6QdPzF8hX2d2XvO1JCJQE7jQzIPI7JraUwZf3kM9
 evvMJ9S9mkht9hGQGGOlhuvjWTB+Vy3r37/oljszEHros1TE37t7pbmvmn8Nh4Dv/j2vBKEpb
 9jmJSAPxLafokosTeFkf/ylvn0i9NP3oLUOcahqvcQVrb4fvUtXKmQ3uxaIWN14c5NNQtD8P0
 k1uc/C/8vlxiVjtvM3aOFkbuDzPoyw080HJz5UO/MFgpsoe90pjcVQO8lntLZsLZFlXGl8ZXz
 0SdZ1Hi7QrVB20UJclRzuttLvqpuo0lh7xLbFuUaC9U54YdSt1d/dQH3nXrjvoF+QWUIy9TVI
 Bo5Me6NKtNCwWXZ3gBFTI7ESm5Oov6r11WghUotAFg42C+hLon0CrIKYbOeB0d04vuqRe6dhU
 VREQqXl5jPr9mPWC8xYZBEQNYda+AEwHHE2trXrdDPSMXhjA/5z148GD9kLwhWPtk5kd7AQ6I
 dqvDySVB4tmxWiuhHzD9E98GUHvw/M/zkw9winvrs5uzzBoMW9Z21/4bOUM5PYrlHiem/Mt4Y
 hWnrkYykoUKYfzGZ8uQCoQyyVOiiUrb2Z+TEDAsKyb3QfR4aOxhxdOHdk7dq8g8szVTCCrgdH
 ZorOOL/Qs8QUdsrkr8hgzy4QsbaHLGom1ybPGDvNEdxfUujdYXiSLThHhelpsmvUlVM+E+Giu
 U0gg5+GKZjGAyd6KuoKIIOQmEEGow5QIAT4Hk6zywAzVkmfvON9oXS3Vj78uIK8ykhaMtRAZ8
 8AF96zJtly//XisW3WKkT2Wu4jmzc4GBaJmYz7QvNGnBjvXVsO9QXbmkqrk8zkvJPNzjSIAKp
 iyTLZkAa6CJ06CZWIvawor+j1apif1ZowDoudCVpyzHvBQAwzMoyZkIJ+aIwfa/usu5+k8wqi
 xfiphs9ZFe0TGuLRs7PjZSNa9nR1fjmPRu5sxbjOi6LNQhyz+51I7ba7yZb8Y6qWubWOV1uD0
 r9mt+92Ier1uyp8LNSGV9WjUqMVZs3WHSjCeUiCs29w6ilKpM8AG4YzLVBmwtDhBlPI2nD2T2
 9JWc9okzocEFyf0zrNDUetSTU7XteBDpe87VZxs
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294024-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de];
	DKIM_TRACE(0.00)[gmx.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: BE9216288A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The bus probing of the MDIO driver uses a two stage approach.

1. The device tree "ethernet-ports" node is scanned to build a mapping
   between ports and PHYs.

2. The children of the device tree "controller" are scanned to create
   the individual MDIO buses.

The first step already checks the consistency of the PHY and bus nodes
that are linked via the ports. But it might miss a dangling bus child
node that is not linked. Step two simply iterates over all bus child
nodes and might read malformed data from nodes not checked in step one.

Harden this and return a meaningful error message.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 517b01115f34..cec2afed5b6f 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -380,7 +380,11 @@ static int otto_emdio_probe_one(struct device *dev, s=
truct otto_emdio_priv *priv
=20
 	err =3D fwnode_property_read_u32(node, "reg", &mdio_bus);
 	if (err)
-		return err;
+		return dev_err_probe(dev, err, "undefined smi bus number\n");
+
+	if (mdio_bus >=3D priv->info->num_buses)
+		return dev_err_probe(dev, -EINVAL,
+				     "illegal (dangling) smi bus number %d\n", mdio_bus);
=20
 	/* The MDIO accesses from the kernel work with the PHY polling unit in
 	 * the switch. We need to tell the PPU to operate either in GPHY (i.e.
=2D-=20
2.54.0


