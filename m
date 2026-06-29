Return-Path: <netdev+bounces-302695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tEDCFhaPQmr39gkAu9opvQ
	(envelope-from <netdev+bounces-302695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:28:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E84796DCA95
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:28:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=LNjSyZqH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302695-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302695-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80962302CA95
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171CC42E00A;
	Mon, 29 Jun 2026 15:24:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF8042B746;
	Mon, 29 Jun 2026 15:24:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746649; cv=none; b=YgESz6p38gxQ+kytNzNibfyZKQk5nPzJ27KOinigtthTSNAqyN4ktY6u/XJNrRg8Opwt/gb1Aof6QRwemoZDK+iWfMgHKkCkH6VSh5+d8MsEjyyJsMXfPZG/Q6SefFrq6YN9VjCETBZ6u1RMCHm46ywWSDGKHC6HhWmz/AzWmto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746649; c=relaxed/simple;
	bh=LCapYXWWa/vdRjTvKZ6CqedFRB72cBND5tKjOh15T34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2ufXREKZf7mtt0Ri3kOGqyXa+t0NlVWwm6ERM+M5UklfkIVdtIEj8RklmdxY2rDPTMwxlrsYQY7lwRTOWQay/nseWApwuW5NqasofAaJcZj/GbddnU08CJpLXwtjC7r/Ca6RFzDfMlh4s832rV4gSaV5V5XvEKkY97yZP58Tbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=LNjSyZqH; arc=none smtp.client-ip=212.227.15.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782746631; x=1783351431;
	i=markus.stockhausen@gmx.de;
	bh=nwD7WgdXu4pbELGPl+hqeDVum1P8ZjApIpYn3DKLVRg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LNjSyZqHd9gXHfDVYziqlvkiauqtu3DWNQUcTr7XARtCuWBSxsCdTynxdmlLPFBw
	 Z8bg/STXIWMt6BUyelFj7DXEi+L54TxxRz9PYsfhhFDXaj9ZBSvLOsRJFZCzSLauK
	 zSe1NODozGSu1G2lOeZU4m43768CPnfy0dwGAq6HSGn9SzG9cq1lt3xyCVwy390JC
	 +V4eUKL2fXmgamBF+oIu9lff4uh4Ld/QA125wxV/af1v+r+0OEE61Dnp2YNZVoTLT
	 HKPA9v2Y8SWgZ7jcAldpxyzhUuYJoYB/sVksdhEh8Qg00tGCTSVoXrMODzURqw0VD
	 NPJRW95TVZB91Wy7xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1xQXA70ziK-00h2ry; Mon, 29
 Jun 2026 17:23:51 +0200
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
Subject: [PATCH net-next v2 0/8] net: mdio: realtek-rtl9300: Add RTL83xx support
Date: Mon, 29 Jun 2026 17:23:28 +0200
Message-ID: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xEiXbVpkPc5+9HtWwXtJ8Z6gGtoo9AP+jj3FPcDKHrfjWhwrzSw
 qk5lmZtDm3xVUZUHHzJenjLA3OROc11e2sgkPjyXjTH8pctCp7zfbt6KYAINZreEJDdf9U2
 AGrj3Ej3ceBDvHP6saRpn1j+TK4zTNjIZxgaoRSU8OvoF0U0QRr2oOAxrlWF/FP4voFnFOZ
 bkmCEBh/aLUjMCiRAcQjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5ZcibnaT9Kw=;bU5xgRAJbdWU2BGVGuCavom99Py
 GmlCAinQ7p1lX7/HvBf5SqkjPG+yeMxOn3bVJhicZsZH23qgdF3NxwRUhoyg33pJXGtM4/8R9
 ZlcNy3Q++T2JZE3p4qe3fQWVuOCxmjn0NgvEpwpCmXCr/SMwgCOs7caT0/gvfcOmpR2WPMpwO
 dX3a1sDDbSG8H7Ny7ZqpNsfu3OpU0UwFRA4PYKXtkttR3i7vviA5GlHc1YZknCtL8D0a2eRHe
 G9m6UkJfgIeflkAhnjZjc8lz74VniiE8Rj17B0XFEUAXcs+dc6wlhTryzOdJQlZbsckCe1RR2
 NUi0CRsXIlh783EHzFxbsT5xhNiurMohsWfWD7EWqSVkApvHg5L2bEHy5jbeXVcWm2yTTvNGo
 XDbj8Jw+egXbwRHcgGPTUyIDnFh8U5maIVAbtWW++0z62P6ZvpD4OEh499loOF1JUtjGURDKu
 LHVk2bBXh3psFcmxk/h9mGkGv3NteGb6IsKs4n6o7efKmShsezy3neqMA2V+Pd+sNNJgZv0YQ
 iTISBA9Fs2OagENmN0yL1e6ID0y0arfjOdY/IQKYaqIAwaI7RpewYrdnXqiYwquqHHWhzQ1C3
 tsfSxhNb3qZnUeN0+N7HrquvGHpDu+jgMkPio0kHDF2wTZ9z1tMtrGL/rSsaU003Vs9yWSJqQ
 /tOzJMqCx6ehalXokoRVrYs2yxoeoKiGWdNGj2pcDgJY5/x2qVZ4rrOgLAEx/JmQKfWhiYJnn
 GbM/6y7/FYrtw9g2r5SYev1dHKKjC3ewB6FTLqoNLF53pVfqIHqHiJbPWV4wm+75uwHzHoy4m
 Km4KC7U8kbqyT1lXQVuwkE4LXZpVo1Q9Hd0fXeFYIlr6oe1XlPU0qqBbwISAP48ZI6doeClnk
 t1iWuMyAGF6NGsEQyY9+GOdTwBgUqepG6TK+/Ll/DFmR6Wd50svwTTzKNfQcuDGkCTYAUIiAo
 zTKkXPqGg8JQYJQpRid02HZvqnPNYORUjXAhTle3sNwiMgfYjOvfNunOvnPBjwaRfpDjBH0fn
 ptOSK6WChl0VG3WcoOE4nhMjrWC0qfX6VWuzvDLtZHVj8rC3DU/OtNOGRQ7hqLckk6HGV4ddR
 LCObFYH7ccOLUbl0//Awry0N5MsUnoJOmRGRNMLUk5ph5+TeE924+BmXJASklPJ9eNfMbnEHr
 mbYzjvJ1YKFHmnuCPvjwZ4af/ibczBcbenpvncTejsvnY1hKXomjtU1QziSaxFnEa92UyC2sQ
 66COESqHGNon2xjttiVWa1En5tv4I5waXVlhJ7Qh9Sk0MvDA9G+4e7SAHoWnLS3alQUfnDA3x
 nH76mletfgNZpo8NFp0PnEBRQwGKqgPfwbbbpslEJiMbloU6f3fTeWUFj7PrXsqXct82Ih88R
 YDh5DlMCEApYyc9IEoHdVMs9JNhUzri7i90EATVU0PsDIiwbTTx869rYC2UU5+gu8AajDyfR7
 1OcMhGNFW1M3AVRfCU3HePkEBnGeSqU4+J+lKGtY6w4JbmzmnMw9TrGGks2ff+AMzzVuzG8bc
 udxdn/y7gMSt4tXt6JYokRNawtCf5DtrxN0pwQa12R6CMLVRJJCM3fSo8lM46ZKRQpDzt9RnK
 aKP6JIeIrUG6X3YQoOOOE7YEJA0NVKMJ2TD9sjk48Gv5jO2mWzUFkV27qhf2pP2SMcxxVSafV
 x1dcY5GnrwxeMgQn/1fodK/E4y93TB4dugErYuxCgtzQ/Yj5fvziVMXPF5m4SBYF1HCu5enXY
 hwF7YtF/iWYcHqDKhOwZ7Z+II1HPmOAbcqA6LaleDfo/zwuyXbaRj5Ggv12cfxYbGxoxCZG5i
 oUryW433auUgFkEdnTYzFs68gulupa1t+JleWL46i+V48ujU+ImsuJuOQZCAe6hB5sl1VD5zF
 5G1pLhfl/YJSsA5nQcRPUbMMJUxqUqTFVHCoh6dwNYodibmBR1ROfMKT+pbeYBknHCZmXsxN1
 Irr8D0LyCAXpKk7PZVjkdGw+UQ+rD9tb7jmvaJBswKx2JfozDZQfDVs3h/XVsKn50GQ5LiBRt
 ggeGZVHaprFu4TdZODja/vUa/sOQ2UkT2EJKOGKNL6i5zEOW79XCytq8zD7GaV2v+n1Xe+G2t
 /KjqNVRdTxxIGuw2zkE51o8/qi04GFGhdyJTFM+El8IPyruHepqfwV1YLOTsQeydXUopAs8l+
 JiGHs0gP99n/1hva4ypDQF89JgjVDooi4j6qZ9eF9ida6Fgekf4l0MXno98dRZEcXuZ2//Seq
 cOGPjV6ldhcrWpVO+cCR4klSIuEiYmd/dC7Tat2fSihQ1jDrzlPsHsolJ+GhWerzIWu14nsYL
 o+Z0sm0sPaJFll1fhUFlZ38cX4iSDFsdnBqE3HWuKirAzo4iOnDyHavFGS5cs41KrRm88fIqu
 XZUtS6YgmmLaCK8U6axgT5+zNx00JfvGMQjhWDBFwa0nV3jzO4H9L3YMBob3pR3mBYEOdznSW
 Hp9WUeKvlDgZNJ1Ait8YtTj0rIwP+oOeTn+36bm4gZyxLA7WJ+QKwA/YVSL1J2VJgRrPoiRdb
 /0GAa9uhawzIlQlZBlJKw/WPn6oNojiY8JgUMJkCv2dgiyOmVIMGtLT80of91ou2zeuIzW9sU
 5P+A9shV6L724FUEwYeWlCACUX/E/SaMzEKTfXY5NQkM2Q4lFUfL+NBFOeciWNtHpFHXzpFAt
 zifFwgXd6m9QlvTy+Z23qLlJI35x+KbfAR3e4aKsIoijBYmMtCsvj3DhiP/fLXVPe/2epzmsz
 vCfimVPqGS1YPvzb+w7SU//W4Z/emctb95b20Q/1JgwNAq4mD+J8lNfIF3fn4+Rl94dnEBp0g
 ZcwqVNRqCy+lidq+VZEStyRgV7xlHGNhjJnbxxqib4XSCh85y0Nu3NNRoLNdVHExZRA13SgQQ
 QFhZbJM/jK8DhGL7BSiBW+iKqm2qavyaxB5V8B+qn1Bi1CIev8tF3LPI2ImB+eTA6pl3KM1/c
 vrKgZy/VNGrwSQL3QTSKnF9PnPJGpEXBUn7dZgWIoHzpBcXbPMPNNtuM74dQVMtyI5wXGYUzY
 B1Ifo9aeU6ee0PZwYSva4S0QhmnbDrHW32RAOxsJVWnN9BfdZZ1LsCdljenwsWCKeFJpbMJrS
 qTfyPUlU0N8znbrHKosjFym6DxRcUrzTwC4LEYLyZcB/ql3ZRet4g5mEYq+Hk6yvPK0TkhObp
 B5dqrroypdzlpGruHEDaftJPq9rpkgtnTxE1O1Rja6IICzGOnmkY2tefWI/eugh42pQGwIEjK
 qi7PWEIobmWX8u6NK/zNYtWxw23QBcMdlihwwYd1mjfJofcCOe3xy0DSinxAXuX86j1q2Mhf4
 5c4YCjCTfUYczmFRHbf5ZpH3CfeDjrKUgKF8bXC0Jtxa9iARaS+uP5ihCEvApTHboUf84EN3x
 HNsbd6H2yF8uM/ZyTHndmDQ8Amr0S5vLYvImVUGQd2lC9wAtjWMpI6Fbb0mK5RMi7IMyv9c7U
 KdxCgVQJAdGLG5U/7cGIIBX7KRK+IWrWCfFnwegBs7RFBzcyjSLtKNC3Hc+39BYDLqQ2l03zf
 ArsS8sPFOV9pNwzMZDeYbnKTfqB3XwZNZ4MUmg7m44GHFwBC2wltO9BQC2Vu6iGYteGiT55PJ
 z7++kerkKtCrbgoTMUu7/MpXjfrcPF1u76UiY+ifNalrE6rc2PvhkQHRkKYEzKTlnFeNwLAWG
 wiMDL36lIA01YIWIr2FbL8ERu/r3zW688mAp66MojVGAiPfC8F1nXkMqsFmNx6lNPnR7nbmuK
 A4Sj7FZlfTukIAXHgonUdqKvIhj1H/zwCTZA30aZcAGZ+1l00kpO4OvJsI3lBYtAaAL2AFa2j
 Ychzqhych4ooOYMHXjkAYo52heK+I8UvZ/1NWVmhdgAvxlqdpXivuMpB6CI8Hy7MYlryF8T3S
 SkzKvzMwthxDLkNJGJH+ynqb1+X8tvTct8PJe1jluGOOhXX5/v8bm873b2ERPyqYXIw3VumYN
 G+1tVHQhUUBkb54IrMzLLiNaQsiVd0FcpzrV/0LleqSAqmOCzi1eC/TG4eoT5z3L71jXx5IO9
 C6ZMc8OC0lYLXrqEHcRh818PaCLbi+PRC12JZsTGrXJvf7LcoqBOmaX5TSufNhE5YGE7KJgPs
 7he59KnoTeKNZvTFi0eLMVwVSI20EimQS+wOUXqKX90CQTkJdt/XD4q0vEBnHsbvrzGVmWS/5
 r0h0IB+FDfJ1ehGcls2FiQSqFfP9/ztOqox0pW276TdTQoH1vybf/rfwHg4h2paFo1GMKzWks
 VJ7P3OQEP0/AhUdvTrWidGG+KNQptVSW6Ixo/CK+0E6n/8wAx0i6kFsx9W8UOmsIb6CBi8ESH
 pmcy44hjDaNn7he6wUKqSy1U0tZsybQiImG+/ARyV/VRgwJWEQ6HYTefSSxN5rQnMchZZyTPh
 /dATFx7NfwRaBwkQddw9qeDVsKfjRY32mum0/iuqSG15xbjXsRDkFu/A1ZbWjWMllvW5U0ft5
 CI0wvc1CQKMCJDJdtZ7vM0x6d92Xv+jR3OgOCwGV3n6tt6FeSAmOWdjAahduOQSEzX1BngyqP
 6yY/R55ZMAtoPbQG1diuz+Osx8UGiBJNFSRfAE0YJ/b3Qcebd7vxolos3pT4N4WcD4jLz7f1R
 TrUDHwYAh0/slFfULFCpudnomta4TOvoOHGd+6ch9aqmNo0+vIi7cpyTD9kCL36U9R0McAOOI
 RBdrh+Lrn9CV7lJ0cec7G9YsfxOnIMCIpdkvYa1ZbbHmpbOy8BV5+Au4GclwTyHKOtHS6Lol3
 +W7WXA0zcLk3+LvAUnIQl7Okxn4ZctBxf9+9B7Ii7Y+gIlD1xNfHCXbNPNb3AVAwTz212wKU9
 aOejanr1x9NZ5Csnbrt3ZB1hS7INstuU4dV31f5r2qiZNhSBW0ybdhvN3sdOx8XwDXMHjWY5p
 p3cwIEPrHHoQl+SLzQ+9PyQu8R2ECBPMAn6b+dM9z+tZg8J5Mv8B8m7eyydcBc610Iqe52Jmp
 X865N66GrGjwJHYBN0LkMGhUeFx85ffWGRvYIxu0GUbUnp5RhTAXHSpIncnWFrCgfUVuSX5+6
 Y7l61fImemDNQ4SSgzW/yMSLtcvVy229l8ZygiOCXVLOpEjisu0e2N7i4enGEzeAwwLMUez4w
 hqQUy4ADRy7/EphzwUCavGNy4sSfv85fFTGsS85G+PBffzjbjBb1twaL7/lTnmpvIxA+loiSh
 XpOgKVhQ8VHUqTDQNHL1Js9IFH2OVNyQjJfNfzqkQI1g4h1vt2edRxtWQnfFKr3LaTKsBHcZU
 Z9lTlEOn/tf/icd9AcvrI3xDgaFf9SeifD1ebRje4cIbJWcNDHjmFCu1VkEcR+lUfynRdU9dk
 M16aC8/P0oxRXzoTORcc5ILNXkpWOl7JjPX9IucQQsRioKNaFkAhBBDaSTTmgqMmV8I39xAIB
 fOKu+JHThxFTo0Mj+T5LZd7HRso/DUr5j81Mc+LNdTu14Wc91YZqIk7RU42ykgu6y3Ebv+mmE
 8H5qlJyX4FyF6krDi30IVz1V9LC+P/uJ6iOT/TSQYb/CdTwKDSdgbL4TSr7lDLC0Ru5SCc67q
 yqF0AycQj9nwTeUveC45b7A8DVxdxUfDgRK3sj7M0PL7N1C50moFLIYs7KxOEc8rxDL2FQCV+
 PoRpdOdAuyEZ+wi8LiC8yhvMvSu+wQ7dRSoq+h5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-302695-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E84796DCA95

The Realtek Otto switch platform consists of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

While the MDIO hardware polling unit and its necessity for the MAC=20
layer was always well known, no detailed documentation was available.
For this series the MDIO bus was inspected with a logic analyzer for=20
a better understanding how polling and kernel access interact on the=20
bus. All this will be explained now in the driver comments.

This patch series adds support for the RTL83xx devices. For this

- Enhance device tree binding.
- Add special handling for limitations enforced by hardware polling.
  These already have minor side effects on RTL93xx devices but are even
  more critical for the RTL83xx hardware.
- Add RTL83xx coding.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--

v1 -> v2:
  - The polling activation logic was refactored. V1 simply activated
    polling after bus probing. Now a dedicated phydev/bus callback
    takes care of this and also handles deferred PHY probing. (Sashiko)
  - Run MMD prefix helper before register 31 (aka Realtek page register)=
=20
    handling. (Jakub's bot)
  - Always run MMD postfix - even if the c22 register access fails. This=
=20
    ensures that the MMD state machine stays consistent. Adapt the error=
=20
    handling inside the postfix function to not overwrite the real MDIO=20
    return code (Sashiko, Jakub's bot)
  - Drop unused RTL8390_PHY_CTRL_PARK_PAGE define. Like on RTL931x this=20
    field must not be set and thus can be ignored. (Sashiko)
  - Change title in device tree documentation. Because of this do NOT=20
    add the Reviewed-by of Krzysztof. (Jakub's bot)
  - Fix wrong use of RTL839x in commit message of patch "c45 over c22=20
    mitigation". RTL930x was wrongly named RTL839x in the list of good=20
    devices. (Markus)
  - Fix typos (e.g. c22 over c45) in polling documentation (Jakub's bot)
v1: https://lore.kernel.org/netdev/20260613112946.1071411-1-markus.stockha=
usen@gmx.de/
v1 Sashiko review: https://sashiko.dev/#/patchset/20260613112946.1071411-1=
-markus.stockhausen@gmx.de


Daniel Golle (1):
  net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus

Markus Stockhausen (7):
  net: mdio: realtek-rtl9300: Add polling documentation
  net: mdio: realtek-rtl9300: Add page tracking
  net: mdio: realtek-rtl9300: Configure hardware polling during probing
  net: mdio: realtek-rtl9300: Add c45 over c22 mitigation
  net: mdio: realtek-rtl9300: Increase MDIO timeout
  net: mdio: realtek-rtl9300: Add support for RTL838x
  net: mdio: realtek-rtl9300: Add support for RTL839x

 drivers/net/mdio/mdio-realtek-rtl9300.c | 450 +++++++++++++++++++++++-
 drivers/net/phy/phy_device.c            |   9 +
 include/linux/phy.h                     |   4 +
 3 files changed, 454 insertions(+), 9 deletions(-)

=2D-=20
2.54.0


