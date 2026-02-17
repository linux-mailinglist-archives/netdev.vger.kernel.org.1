Return-Path: <netdev+bounces-259012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMHULgNQlGktCQIAu9opvQ
	(envelope-from <netdev+bounces-259012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 12:24:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A2F14B517
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 12:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 170C2300DF7A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 11:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CBE3321BE;
	Tue, 17 Feb 2026 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="R7wDfMN/"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E28318BB2;
	Tue, 17 Feb 2026 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327487; cv=none; b=KF/ykAaKECJjqmRQ6RNHjRqHl7VmCAFfc2abOR7nOH1TYs0XVL+SAy0TtpDKvj32t6KgUxVV1ViC05CZ1zSS+z/YMHtHk0GN2A1/wn7HLwqYOaM7qJjHCaHCCMJJUr1LeJ78LxYwQjiQBxP9ZGuRRzwFYMr6fZnS741kqxEngYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327487; c=relaxed/simple;
	bh=9Aj9K6Fz8HL8eIyvWE+B9uGyQg/dhv96WbL33oN6wjw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OJql/VH2hGymABnSVUU+U5Y4UfkUaBNK5yJGnn9htjfsYFXVGTVry3mL0rUKX3xcZ7wChjqHimlozMPqyeVLc2ZYm+/QA3yHM4fFtwHK2ySJfv1Z6BMkozcFhKInjk2VHVzam6QdSPORs0BmpJBaoP+3SUnAxXb862D6bT4ibLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=R7wDfMN/; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771327453; x=1771932253; i=spasswolf@web.de;
	bh=MCHnrmyJ6VsfcikPgUIwC+4jz1C/xu6RELAawCyd2SA=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R7wDfMN/zm5OqGQAzsEcqcWVe7BIZUmwCGGuQ9TADkzGFWYZ44mDxpRqrIl4hJxd
	 31EW5Mw4jNp7HkCUtfGXKP/GfEg7RVCspy7o1zk+4g48+grXKYZ/3RWM6Hfae37ob
	 uMaRNseO3q95Wnow+cbaGBTCZp2ZdZLGxL7zvxx/41/df4Rbk55u0VPiR4Ma0Iw13
	 Hp34SntN0hbMtxtZq6BoG98mvmtyJFX6d4+q8wos53pIXPG6Z+/SE1cZ90woJTYyZ
	 YkxdNXjBtkDbcV95Y7466Ps6vc1W7odic0kPAX+sR01Bw89FSKoY/5XV6KA7DyKO4
	 cF3P1qKjqStKUW8YJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MElVH-1vzlyR43x5-001JOw; Tue, 17
 Feb 2026 12:24:13 +0100
Message-ID: <fd609cfe186ee48e0e9a08e35764175a2516dd14.camel@web.de>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, spasswolf@web.de, Jakub Kicinski
 <kuba@kernel.org>,  Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org
Date: Tue, 17 Feb 2026 12:24:12 +0100
In-Reply-To: <4fba57892e5bd6a1afc4a36a80b40e3ecc28cac5.camel@web.de>
References: <20260216134333.412332-1-spasswolf@web.de>
			 <6274de932f4a62c51b424b65fc875ef3cb5ffd60.camel@web.de>
			 <20260216153745.CA3__zRc@linutronix.de>
			 <37d6e27f96afb57c5716798530cb3560d25202e5.camel@web.de>
			 <20260217071952.WCXLGs5-@linutronix.de>
			 <80114792206dc00d0099f00999a209e717debb12.camel@web.de>
			 <20260217095700.SjYjM8RO@linutronix.de>
		 <4fba57892e5bd6a1afc4a36a80b40e3ecc28cac5.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZTBF9XoXJtVlCRW7QxUcAvusgGZrvAhXutr0ZCZhcazNQ2w1cAw
 vzPMBqy7fR8F2OeeHKKLtZBzbn6dcZghicLn4DTeeLg3ZdHrOnyJzcz6TCEccFpJmhhgw4V
 a0CQIVEGoBduNWNxFQDnCV3FcZz+YlTW1cf46rSz3BNAYjcFbuUUhrg+SE9713fRUqOOL6K
 z1NS+WPN33JirO4b3GHjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pmeGBI7aAwg=;qwdTv8xhtN7UUSoN0xOzduP5Vb3
 kitLkQzc0mw5r5NJW+Of7sC2922F9B3NuBDWIpdAOfArrP4gb9SoLKnNWE3ulqwu+xX72lTWp
 83y06mM3wQYNgNqA4/7y3edX4EKmxjpyrvxhogtKdlxDS7OskTE9EUixSb8OSkK9stb+VYxvx
 4h0MF2PJm7FjtPa0G44ayPcepq++LzzZRJI6SgAc27QbU4X2+pRYKqv0IbH9bSAPzn7sYHzPj
 RL0Gd/InijMvvVGr9ad+moX72eIfTFwgYyQAnsDpw8q0Inh4k6CrMiHf3l3hkNFdQUQGF5T6h
 5i1p2auOc0ayCPOxYX1qNIwUTOCoIOgoVbL2gjRpgTvJk+4VK9uX/FAXwQ580NSpjmh7uVvKJ
 00tzH1+TAZ4IAiW3t1+tk2RHrLE3yJcpzGu2CAdNFCA2zv3kyQbhsL/1OBIPKIQA0OE5RCVix
 aA/2yLcqereRuVi0vyjKaaJ/G5W0H5ebypJogaNVGhspRniSiRu9kov2WD6aLvYotBwwzLK4T
 sCptXipGAX1+bysFcQWjOAw7Q05MuQIBqoQUNSbdgXOObsmKrWouKoGbokMi62OyP8phTJjju
 sKcu2Sf16Tak1jRDWOrz6m5eMS3Ow3rQTcfgLq51K6qJJbyyX5TM0aFFH4ncDeLezEsWgIsHs
 iFRkZCwPLjIf59OP/fgcJzVs4twwVeZbjWyEZPbxPa4lM6QCgorDWeRHTsvktAI1h27U4eOoR
 M08Kh66rDPJiZfjRCPBanDEJUdrodKB3/qsWwVrYHvR9qZkUbnIIE7PTAKiW0RNwaWhaJtOdR
 ytsROG6kEPLB64gJlVWfD+deF44ITmYdXbbpC8ZysDC85Q0Ucr4z6p9GnRYWVHk8DJ8fifGyA
 a3527efuaYAEAzrqhwJ6IGAhJOw2vf++4vty2oiAf6e7uHYk3XDEkHflqK918NqzHpBWFlM1c
 K9i4of/KIpXoLH8ACpGL7ahmOeSTCQP2mNcNMsqtr7ScWdnB5gUel0q5LpeZ3e7363EiruMRb
 V/wP67j1nFI0c8IvKgyLQ2iYKQDaU+VcpnASaKfEpy6N3ejJaiVfRgRu62vQPlH215obfSETP
 sYNJcpmMYgKlmy0ARNYnXXNVhClJehpDJ2yRcNVXC7fgGQQ0vMVvgaabGnNXSxGOLeGl3aXzs
 E9u+q0/f15pxBujyC5R3HUbDZw/khNC69ctQXVW+dLiGOFCg1d+vlh5Tco3+9eCg00KeeqY7u
 8Ajph7rfeZEIcsT9RRSU2yhpZBU8E3vKQtQ3s4WFyMVAxHxV1Cgl/nTAQYNaq9mt9Qn0CZ969
 VqmLqIzXbY8Gl5v2uBb+nlRqdg63a2loZHlob3GVTwUSmLCefBQbJe5KcV3NbM5vGRsa/yoL9
 ZC2OFL4rDm7stNaZt+XxIynXF9DKB5h1pj+KxoHZKvKQvPfC3dSQ6nipSEa6qw4qCd98Bs8CA
 AqjTyawaDXB8JaosTBWxgdTlKhOOTF4vLIo6JnC/kUQmNBHWj7C6HiBWh3TyHbnrjFcQsxTb7
 hvB6r15naudGsIBhn7paZ2jmYZ15pun+M8apKGRRblGI0U8L28usVCG0t7GRL0lKaoTCN9eNp
 KCdebz6lbcGfGyo/mBZQrlLIudQWUateLWKQe1twg4UkwSHwuw76LqFNwf9g8nAXPy40ThyJT
 FHltABdWfEh8E5cQg0cjIMhyLDkpnCuTUug3OHMXO68pZqPv/LkAskAJgiX5brF1DEjTIZRCa
 bASnJauqHdWi0YFoPK0COE1uiDcbT08MsdPguYRT03TgR6iLJSF/ZGDDj+77G5NKJl1r/fIy+
 AGYN0OYc2pORTh/66ryf4P+afDaPOfejU8VStYtaPfkmLBLbNs+DrpMCVSw7iQVww251XjNYa
 rJRw3Xt0kmAJaUlcrqbbfHAfZ3HfENd6lMWm/So+ZDfIAn+e3OE2M8nFv6tSxotepLlAExNfa
 rB+XwE6BcxRJhHk5Bu94Cc+n73I4xbfHUQx2znvUTI26tRlaZtajj3tNuBvHAkpwH5fTqWrEJ
 DaCEzRLzhG0cjIBJl4WNXrP0QTZ/pJ894M/b0io63+PGi9SHPuveSfhIH3ueQzPCmv0cE0K4O
 5qeectioLilyNxK53yoXBNsd7lgrItEU/e0rXelaIn5rgQSZAm7ASBjD7A376s/6+ATTc0S11
 qmT/sj/YjOrbsT61GmoPB1a8j0YOWOgFoMnnXTZzPC4fe/n72SKd8DmcOk/rUwE0HB7hnwPQS
 e30K0xYFfm7M0+3Jkak9JMCWc8MWq/63w9gvy5TvtB86yhj7GldEn9OtOjJApINBtUBa1nNBL
 2gB7LcuRmSRSGyscuZujXxYCxKKTJqH8mZgp3L0tSoltC9sMYSnvNl1bejYEjm/33DZ4VDBxm
 FvRqAzR9l//qyXBqxTA2HI6u91Z9gzuKq+sJQs6pOYjBCHvdmrP7SLH6kklvvlfkjLnk1zX80
 idMkRT8rBEdeMLOu4ElSa5xKXKFCCmtn2/qGt3agcyYgsbIT6s2HfrGRmQHxdAFQVmOVjsgCL
 cTiJR5mkIG1pu0EcyXpIJ/Mp/IhG5ZMhH49IL7dS2SvgBmtbUz9/erOSSamfKIvxTL+HIm5n1
 VGQvugbMW2o6T7p4ilzXke/OxqbnfAPnsLS8Wx1UsFh8njZYgd9Ovv7McEGy6PwBjDMe/e3YN
 GSgjyBvw2uPVSSr2yn3lpC4NpzgXAN4kW+oTQji2PDaEpGIrHxLLDpjnMnKgeIsbTIsrfO4SG
 LKBi885Fj+0v4D8w9kgMMqYjspo8TkeE4vVJnNYcLRhjcGP5tYRP/s+sPvEij1FYYTfEuWlUT
 lP2mOAPKt9Erq4NAUIC+6xGmk2e7/5cPHfIKgojr79JmQRFUrf1nTtQWRNC6DkSdRirhp5gQn
 2Eh6D6fbo3nu8AVB3LttCX00bO0PcvmUkY9otSX5/Qtrs1/LUogyOZtzYZeJNKQ81BVq2SVJU
 heu6EU6gIilItE6BKquCmR+/ycWX4M82NgZhFo2arNzBxNVevxfzUpblsC2hRIwfFH7K96p8B
 Pl4UeWbTFR+C96KYAZBIhwMexB/fMu9ZU49ryIghNPVpU1LTNeLoAQ6CDeGFfZR7IDFdscdj3
 /Oi9awuWbPGKbTMKkFN0fFMfCiscYAxCrM2XhW7jo6qyhXi80MbHEhIgr6rKqYBDmjYj+K4le
 ETbL29VKFV62Tu0RWo9Ks1/1WDl49DUMy64xsMmp+3Qw7e+fySNH+N959Ye+glqg+3q1jweyf
 +7tp4IHCmI8bY5b9PIme3DacNpVSsKK4zwG+C+ZBrGhu0GKyzpC3gZrxSLbAgs0649JPu5hdZ
 ljcQC9WzNJOmXpxvZq/y6Hp7d9lVOPVvUTPO2FR4O9vKfdvedb9iqOsSzBkkl97X16kvgfc3E
 Bk2jXQDV78KzKNAbchYslRt5OjOZFW6gCQp7pcmepmQ37PDnTGR7EsfP4v48Zuep7ACuLCNa9
 Tf+3QdmEeNpMUH1fKM+jZ7q8w80eTShP/VUA6RpWQob8MDJjT3DtN+ldYz9sJwYlvBHCubTyF
 DeZBtdB7/nXrMxuSr9XR3vzDlhA4C3L5DqX/O3f+0sMK6A8h6GIJJbT+98u92kH2YUHH5E06d
 oXEYpKkOexOrAMjWryzPO9MVzvUC0LMT4heaFukeWNEs7HvqubdIrlqbnoFg03WydnVEeV8z8
 rJe4e2zxWPn1OGrcewiiaifhT1N7jx4J27WDQ2k/L5UvjwcOO1H9KLZyLVX3fEtYJMiPRb8fI
 hnl6ysPlAS5+6HWBSJquCz7ouJuF3LK/zaTjeU0dGKPIIEdllPUAMSkQtsya5Sij2b0o0q3/N
 /OFVtfgv4T9izdYGyQf2SKw3fObukho0aGICdbmGyuKq9C0WTdg3l0hJ6JGGIoWQ5olXFMvP2
 eYApQb5NxHefBlA3MW9oOtJjg0zjDSs6pBjjDgLY7IbItqpTqDgxduazBM6mERZlEjotyczPL
 /Yh2X1A7uoF56BpLBNUlzeXh9oiDgLT517/vvH6sauAWiQmhXo7KcRIX+cFp5yX3jxUISrodm
 d5HvFk0wSjIyvwVf1pW8pGzqfxiyx7xsGeXCmAmBbbn5RgOu3vsPzfcARsglSZk7+UpCPV3TM
 a40IAmj/ZQD+eIx3LbhMviMBeHsqdQWx8rMh9mm8wYxHjiAiMQxsdwIye3uqGCCl4Hx+fQNGQ
 GLIUalhxdquEelqG3S+crwoVHGt5Ghl9g5yQPGV1kyLf2GOGffUyA8nqDBzd6dq1QY4nbII1M
 AS9Wq6kZpE+P2z5azN3bAmwbbxtuZMXpQwcOXHBm2POfBpGpfZn2Y3WVWeF990YYcMnPtKTDv
 ZU11k93wVoUov1+Kf/XD8dB+Wa7JSdwX2KN7jBsyCuKTlqEEcbn53jP3SP6zOpKfg0Aud032z
 mpvwIxtyeN5L1qqfMntyj3n+U2glNk+R8o9XXwak2vYqxhs46b92eJqM+P9pVcytQcszMKk7m
 xpM4V6xQC5WJFd8F6OZhq+aTErNLIxOw7Ndf9VZo+UvaraFoYf4xNc6zrQvbwchJuNKRxOeQr
 9m6LPHuwFmg/namsHprsZv/bBiEuhTkBBA4MYhtkIzeKP/+5TBVJ6/Jamr5z+9+Uw31BPMvIu
 FV/vZI2jDW9H2/OiGTqCM4RJt6cJDJ1uP0PgZp+vOWMrpRU3eDRKXuANiKjWm7S765QteYuTA
 AxDyTIPdZo8bfJn3EQEtMJSLuW20pBmZN2LOxGN8K15ro7rr/RY4Owbgx4FL/9ShPnGTqUgzW
 l6g2ZCLyS03LRPOKGN0UC13U0ep7Kf+U9HYP2ME33sFcYHoB0PntZpd/WEry6Fpmgo7m8anLJ
 uNJ2IPClNoQB1pZEgJmP85VoZFCqGL8xJ66lkYIpZrp/Z6NvkSJRxh177YN65EWYV6kQkJtXj
 axXsk4+uE13L03NYRj9DqjeQJm1wqebumjNtOtypf2pBOGTNRbfieg3aS+lG4afn69SFrFjm7
 Lp3LKYfRVfFT5Isib5wMyiqSeUd40tNWenm3mCDoVlGsWWmGkWS3dn9f2QeKnPlrUytIgb2D3
 xVgMAgqzoJcocJsRWqlBeEV7vqUiVWxGYINEcm0guJ9CjIs0Pq1DYqU9B9FOVRCVoNrjEnX20
 xc31CSJicUlJ/9UKuxdxY7mwwxtn9V2oVLWVRIVzvd/dqo4QK/ovNHlkSTv8vEHSKDHEdr6+W
 It4dPhtC1WNLh0H8Jax8UipoDlGZemRQypGB7mQodbkclGPUOuOsIzh4babW2VbpLK2RbR0w=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259012-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linutronix.de,vger.kernel.org,lists.linux.dev,web.de,kernel.org,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spasswolf@web.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[web.de]
X-Rspamd-Queue-Id: A8A2F14B517
X-Rspamd-Action: no action

Am Dienstag, dem 17.02.2026 um 11:42 +0100 schrieb Bert Karwatzki:
>=20
> I just wondered if we can completely skip the
>=20
> 	if (READ_ONCE(txq->xmit_lock_owner) !=3D cpu) {
> 		[...]
> 	} else=C2=A0
> 	{
> 		/* "Recursion" alert */
> 	}
> =20
> check, as the synchronization will we provided by HARD_TX_{LOCK,UNLOCK}.
>=20

I thought about that again, and it seems like a bad idea as (in the non-pr=
eempt) case
other threads trying to access the queue would wait for the spinlock to be=
 freed, perhaps
one can just change the code like this:

commit 05026868843a4eea51d45811d87706f36896e828
Author: Bert Karwatzki <spasswolf@web.de>
Date:   Tue Feb 17 12:08:35 2026 +0100

    net: core: dev: don't warn about recursion when on same CPU
   =20
    This prints a message if we're on the same CPU and the lock is
    already taken, in a production use we would of course skip this
    message.
   =20
    Signed-off-by: Bert Karwatzki <spasswolf@web.de>

diff --git a/net/core/dev.c b/net/core/dev.c
index 5b536860138d..cac5588640b3 100644
=2D-- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4784,15 +4784,18 @@ int __dev_queue_xmit(struct sk_buff *skb, struct n=
et_device *sb_dev)
 			net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
 					     dev->name);
 		} else {
-			/* Recursion is detected! It is possible,
-			 * unfortunately
-			 */
-recursion_alert:
-			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!=
\n",
-					     dev->name);
+			net_crit_ratelimited("Lock taken already on %s!\n", dev->name);
+			goto lock_taken;
 		}
 	}
=20
+	/* Recursion is detected! It is possible,
+	 * unfortunately
+	 */
+recursion_alert:
+	net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n=
",
+					     dev->name);
+lock_taken:
 	rc =3D -ENETDOWN;
 	rcu_read_unlock_bh();
=20

With this I get these messages (be skipped in production code)
instead of the "Dead loop on virtual device":

[   51.994435] [   T1525] Lock taken already on wlp4s0!
[   51.994546] [   T1525] Lock taken already on wlp4s0!
[   51.994650] [   T1525] Lock taken already on wlp4s0!
[   51.994746] [   T1525] Lock taken already on wlp4s0!
[   51.994845] [   T1525] Lock taken already on wlp4s0!
[   51.994948] [   T1525] Lock taken already on wlp4s0!
[   51.995037] [   T1525] Lock taken already on wlp4s0!
[   51.995128] [   T1525] Lock taken already on wlp4s0!
[   51.995220] [   T1525] Lock taken already on wlp4s0!


Bert Karwatzki

